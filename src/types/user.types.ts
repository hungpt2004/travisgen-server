import { UserStatus } from "src/modules/users/enum/user-enum";

export type User = {
  id: string;
  email: string;
  password: string | null;
  firstName: string | null;
  lastName: string | null;
  status: UserStatus.active | UserStatus.inactive;
  isVerified: boolean;
  createdAt: Date;
  updatedAt: Date;
  currentVerifyToken: string | null;
  currentHashedRefreshToken: string | null;
  isSocialAccount: boolean;
  subscriptionPlan?: any;
};

export type UserWithoutPassword = Omit<
  User,
  | "password"
  | "currentHashedRefreshToken"
  | "currentVerifyToken"
>;


