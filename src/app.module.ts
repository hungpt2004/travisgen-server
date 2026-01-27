import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './prisma/prisma.module';
import { ConfigModule } from '@nestjs/config';
import { AuthModule } from './modules/auth/auth.module';
import { database_config } from './config/configuration.config';
import Joi from 'joi'

@Module({
  imports: [
    ConfigModule.forRoot({
       validationSchema: Joi.object({
        NODE_ENV: Joi.string()
          .valid("development", "production", "test", "provision")
          .default("development"),
        PORT: Joi.number().port().required(),
        DATABASE_URL: Joi.string().required(),
        JWT_ACCESS_TOKEN_EXPIRATION_TIME: Joi.number().required(),
        JWT_REFRESH_TOKEN_EXPIRATION_TIME: Joi.number().required(),
        JWT_ACCESS_TOKEN_PRIVATE_KEY: Joi.string().required(),
        JWT_ACCESS_TOKEN_PUBLIC_KEY: Joi.string().required(),
        JWT_REFRESH_TOKEN_PRIVATE_KEY: Joi.string().required(),
        JWT_REFRESH_TOKEN_PUBLIC_KEY: Joi.string().required(),
      }),
      validationOptions: {
        abortEarly: false,
      },
      load: [database_config],
      isGlobal: true,
    }),
    PrismaModule,
    AuthModule
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule { }
