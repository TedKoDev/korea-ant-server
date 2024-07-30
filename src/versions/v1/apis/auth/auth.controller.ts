import { Body, Controller, Get, Post, Query, Res } from '@nestjs/common';
import * as config from 'config';
import { v4 as uuidv4 } from 'uuid';

import { Response } from 'express';
import { EmailService } from '../email/email.service';
import { AuthService } from './auth.service';
import {
  ConfirmEmailDto,
  GetTokenDto,
  GetUserInfoBodyDto,
  LoginUserDto,
  RegisterUserDto,
} from './dto';
import { AuthorizeDto } from './dto/authorize.dto';

@Controller({
  path: 'auth',
  version: '1',
})
export class AuthController {
  constructor(
    private readonly authService: AuthService,
    private readonly emailService: EmailService,
  ) {}

  /** GET */
  @Get('confirm')
  async confirmEmail(
    @Query() { token }: ConfirmEmailDto,
    @Res() res: Response,
  ) {
    await this.authService.confirmEmail(token);
    return res.send('Email confirmed');
  }

  @Get('authorize')
  async authorize(
    @Query() { client_id, redirect_uri, response_type, state }: AuthorizeDto,     
    @Res() res: Response,
  ) {
    if (response_type !== 'code' || client_id !== config.get('cafe24.clientId')) {
      return res.status(400).send('Invalid request');
    }

    res.render('login', { clientId: client_id, redirectUri: redirect_uri, state });
  }

  /** POST */
  @Post('test')
  async test() {
    const emailVerificationToken = uuidv4();
    return this.emailService.sendUserConfirmation(
      'yongp98@naver.com',
      emailVerificationToken,
    );
  }

  @Post('register')
  async register(@Body() { email, name, password }: RegisterUserDto) {
    await this.authService.registerUser(email, password, name);
    return {
      message:
        'User registered. Please check your email for verification link.',
    };
  }

  @Post('login')
  async login(
    @Body() dto: LoginUserDto,
    @Res() res: Response,
  ) {
    const { email, password, redirect_uri, state} = dto
    const result = await this.authService.loginUser(email, password);

    if (!result) {
      return res.status(401).send('Invalid credentials');
    }

    const redirectUrl = `${redirect_uri}?code=${result.authCode}&state=${state}`;
    res.redirect(redirectUrl);
  }

  @Post('token')
  async getToken(
    @Body() tokenDto: GetTokenDto,
  ) {
    const { code, client_id, client_secret, grant_type } = tokenDto
    if (grant_type !== 'authorization_code') {
      throw new Error('Unsupported grant type');
    }

    const innerClientId = config.get('cafe24.clientId');
    const innerClientSecret = config.get('cafe24.secret');
    if (client_id !== innerClientId || client_secret !== innerClientSecret) {
      throw new Error('Invalid client credentials');
    }

    return this.authService.getToken(code);
  }

  @Post('user-info-body')
  async getUserInfoBody(@Body() { access_token }: GetUserInfoBodyDto) {
    return this.authService.getUserInfoBody(access_token);
  }
}
