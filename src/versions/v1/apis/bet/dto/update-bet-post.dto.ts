// src/bet/dto/update-bet-post.dto.ts
import { PartialType } from '@nestjs/mapped-types';
import { CreateBetPostDto } from './create-bet-post.dto';

export class UpdateBetPostDto extends PartialType(CreateBetPostDto) {}
