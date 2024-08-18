// create-ad-banner.dto.ts
import { ad_banner_status } from '@prisma/client';
import {
  IsDate,
  IsEnum,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
} from 'class-validator';

export class CreateAdBannerDto {
  @IsNotEmpty()
  @IsString()
  position: string; // 'TOP' | 'BOTTOM' | 'LEFT' | 'RIGHT'

  @IsNotEmpty()
  @IsString()
  company_name: string;

  @IsNotEmpty()
  @IsNumber()
  contract_period: number;

  @IsNotEmpty()
  @IsDate()
  contract_date: Date;

  @IsNotEmpty()
  @IsDate()
  start_date: Date;

  @IsNotEmpty()
  @IsDate()
  end_date: Date;

  @IsNotEmpty()
  @IsString()
  image_url: string;

  @IsOptional()
  @IsEnum(ad_banner_status)
  status?: ad_banner_status;
}
