// src/bet/dto/update-stock.dto.ts
import { PartialType } from '@nestjs/mapped-types';
import { CreateStockDto } from './create-stock-post.dto';

export class UpdateStockDto extends PartialType(CreateStockDto) {}
