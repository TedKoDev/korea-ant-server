import { report_target_type } from '@prisma/client';
import { IsEnum, IsInt, IsNotEmpty, IsString } from 'class-validator';

export class CreateReportDto {
  @IsEnum(report_target_type)
  target_type: report_target_type;

  @IsInt()
  target_id: number;

  @IsInt()
  reported_user_id: number;

  @IsString()
  @IsNotEmpty()
  reason: string;
}
