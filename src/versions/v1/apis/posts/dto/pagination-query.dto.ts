// src/posts/dto/pagination-query.dto.ts

import { post_type } from '@prisma/client';
import { IsEnum, IsInt, IsOptional } from 'class-validator';

export class PaginationQueryDto {
  @IsInt()
  @IsOptional()
  page?: number;

  @IsInt()
  @IsOptional()
  limit?: number;

  @IsEnum(post_type)
  @IsOptional()
  type?: post_type;

  @IsOptional()
  sort?: 'latest' | 'oldest' | 'popular';
}
