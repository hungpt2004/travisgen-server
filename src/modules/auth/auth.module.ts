import { JwtAccessTokenStrategy } from "./strategies/jwt-access-token.strategy";
import { JwtRefreshTokenStrategy } from "./strategies/jwt-refresh-token.strategy";
import { Module } from "@nestjs/common";
import { AuthService } from "./auth.service";
import { AuthController } from "./auth.controller";
import { LocalStrategy } from "./strategies/local.strategy";
import { GoogleStrategy } from "./strategies/google.strategy";
import { JwtModule } from "@nestjs/jwt";
import { GoogleAuthService } from "./google-auth.service";
import { RolesGuard } from "./guards/roles.guard";
import { UsersModule } from "../users/users.module";
import { PassportModule } from "@nestjs/passport";
import { EmailModule } from "../email/email.module";

@Module({
  imports: [UsersModule, PassportModule, EmailModule, JwtModule.register({})],
  controllers: [AuthController],
  providers: [
    AuthService,
    GoogleAuthService,
    LocalStrategy,
    GoogleStrategy,
    JwtAccessTokenStrategy,
    JwtRefreshTokenStrategy,
    RolesGuard,
  ],
  exports: [RolesGuard],
})
export class AuthModule { }