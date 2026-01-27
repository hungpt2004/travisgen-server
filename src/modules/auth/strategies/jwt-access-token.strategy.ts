import { Injectable, UnauthorizedException } from "@nestjs/common";
import { PassportStrategy } from "@nestjs/passport";
import { ExtractJwt, Strategy } from "passport-jwt";
import { TokenPayload } from "../interfaces/token.interface";
import { ConfigService } from "@nestjs/config";
import { UsersService } from "src/modules/users/users.service";
import { UserStatus } from "src/modules/users/enum/user-enum";

@Injectable()
export class JwtAccessTokenStrategy extends PassportStrategy(Strategy, "jwt") {
  constructor(
    private readonly usersService: UsersService,
    private readonly configService: ConfigService,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: configService.get<string>("jwt_keys.access_token_public_key"),
      algorithms: ["RS256"],
    });
  }

  async validate(payload: TokenPayload) {
    const user = await this.usersService.findOne(payload.sub);
    if (!user) {
      throw new UnauthorizedException("User not found");
    }

    const isActive = user.status === UserStatus.active;
    if (!isActive) {
      throw new UnauthorizedException("Account is deactivated");
    }

    // Return user info with payload data
    return {
      ...payload,
      userId: user.id,
      email: user.email,
      isActive,
    };
  }
}
