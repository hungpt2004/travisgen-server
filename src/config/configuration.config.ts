export interface DatabaseConfig {
	url: string;
}

export const database_config = () => ({
	database: {
		url: process.env.DATABASE_URL,
	},
	jwt: {
		access_token_expiration_time: process.env.JWT_ACCESS_TOKEN_EXPIRATION_TIME,
		refresh_token_expiration_time: process.env.JWT_REFRESH_TOKEN_EXPIRATION_TIME,
	},
	jwt_keys: {
		access_token_private_key: process.env.JWT_ACCESS_TOKEN_PRIVATE_KEY,
		access_token_public_key: process.env.JWT_ACCESS_TOKEN_PUBLIC_KEY,
		refresh_token_private_key: process.env.JWT_REFRESH_TOKEN_PRIVATE_KEY,
		refresh_token_public_key: process.env.JWT_REFRESH_TOKEN_PUBLIC_KEY,
	},
});
