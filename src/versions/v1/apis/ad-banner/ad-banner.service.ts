import { PrismaService } from '@/prisma';
import { Injectable } from '@nestjs/common';
import { CreateAdBannerDto, UpdateAdBannerDto } from './dto';

@Injectable()
export class AdBannerService {
  constructor(private readonly prisma: PrismaService) {}

  async createAdBanner(dto: CreateAdBannerDto) {
    return this.prisma.ad_banner.create({ data: dto });
  }

  async updateAdBanner(id: number, dto: UpdateAdBannerDto) {
    return this.prisma.ad_banner.update({
      where: { id },
      data: {
        ...dto,
        updated_at: new Date(), // Ensure updated_at is set
      },
    });
  }

  async findAll() {
    return this.prisma.ad_banner.findMany({
      where: { deleted_at: null }, // Only show non-deleted banners
    });
  }

  async findOne(id: number) {
    return this.prisma.ad_banner.findUnique({
      where: { id, deleted_at: null }, // Only show non-deleted banner
    });
  }

  async remove(id: number) {
    return this.prisma.ad_banner.update({
      where: { id },
      data: { deleted_at: new Date() }, // Set deleted_at to current date/time
    });
  }
}
