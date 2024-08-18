// src/bet/dto/create-stock.dto.ts
import { IsNotEmpty, IsString } from 'class-validator';

export class CreateStockDto {
  @IsNotEmpty()
  @IsString()
  readonly name: string;

  @IsNotEmpty()
  @IsString()
  readonly symbol: string;

  @IsString()
  readonly description?: string;
}
