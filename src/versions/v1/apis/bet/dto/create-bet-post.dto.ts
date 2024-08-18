// src/bet/dto/create-bet-post.dto.ts
import { IsInt, IsNotEmpty, IsString } from 'class-validator';

export class CreateBetPostDto {
  @IsNotEmpty()
  @IsString()
  readonly title: string;

  @IsNotEmpty()
  @IsString()
  readonly content: string;

  @IsNotEmpty()
  @IsInt()
  readonly stockId: number; // 주식/지수 ID
}
