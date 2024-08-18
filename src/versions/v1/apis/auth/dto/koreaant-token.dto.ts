import { IsNotEmpty, IsString } from 'class-validator';

export class koreaantGetTokenDto {
  @IsString()
  @IsNotEmpty()
  koreaantCode: string;
}
