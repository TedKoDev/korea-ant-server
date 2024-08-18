import { PrismaService } from '@/prisma/postsql-prisma.service';
import { Injectable } from '@nestjs/common';

@Injectable()
export class LikesService {
  constructor(private prisma: PrismaService) {}

  async togglePostLike(userId: number, postId: number) {
    const existingLike = await this.prisma.like.findFirst({
      where: { user_id: userId, post_id: postId },
    });

    if (existingLike) {
      if (existingLike.deleted_at) {
        await this.prisma.like.update({
          where: { like_id: existingLike.like_id },
          data: { deleted_at: null },
        });
        return this.prisma.post.update({
          where: { post_id: postId },
          data: { likes: { increment: 1 } },
        });
      } else {
        await this.prisma.like.update({
          where: { like_id: existingLike.like_id },
          data: { deleted_at: new Date() },
        });
        return this.prisma.post.update({
          where: { post_id: postId },
          data: { likes: { decrement: 1 } },
        });
      }
    } else {
      await this.prisma.like.create({
        data: {
          user_id: userId,
          post_id: postId,
        },
      });
      return this.prisma.post.update({
        where: { post_id: postId },
        data: { likes: { increment: 1 } },
      });
    }
  }

  async toggleCommentLike(userId: number, commentId: number) {
    const existingLike = await this.prisma.comment_like.findFirst({
      where: { user_id: userId, comment_id: commentId },
    });

    if (existingLike) {
      if (existingLike.deleted_at) {
        await this.prisma.comment_like.update({
          where: { comment_like_id: existingLike.comment_like_id },
          data: { deleted_at: null },
        });
        return this.prisma.comment.update({
          where: { comment_id: commentId },
          data: { likes: { increment: 1 } },
        });
      } else {
        await this.prisma.comment_like.update({
          where: { comment_like_id: existingLike.comment_like_id },
          data: { deleted_at: new Date() },
        });
        return this.prisma.comment.update({
          where: { comment_id: commentId },
          data: { likes: { decrement: 1 } },
        });
      }
    } else {
      await this.prisma.comment_like.create({
        data: {
          user_id: userId,
          comment_id: commentId,
        },
      });
      return this.prisma.comment.update({
        where: { comment_id: commentId },
        data: { likes: { increment: 1 } },
      });
    }
  }
}
