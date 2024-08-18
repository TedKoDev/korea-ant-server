// update-ad-banner.dto.ts
import { ad_banner_status } from '@prisma/client';
import {
  IsDate,
  IsEnum,
  IsNumber,
  IsOptional,
  IsString,
} from 'class-validator';

export class UpdateAdBannerDto {
  @IsOptional()
  @IsString()
  position?: string;

  @IsOptional()
  @IsString()
  company_name?: string;

  @IsOptional()
  @IsNumber()
  contract_period?: number;

  @IsOptional()
  @IsDate()
  contract_date?: Date;

  @IsOptional()
  @IsDate()
  start_date?: Date;

  @IsOptional()
  @IsDate()
  end_date?: Date;

  @IsOptional()
  @IsString()
  image_url?: string;

  @IsOptional()
  @IsEnum(ad_banner_status)
  status?: ad_banner_status;
}
