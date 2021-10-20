import { ConnectionOptions } from "typeorm";

const config : ConnectionOptions = {
    type: 'postgres',
    host: 'localhost',
    port: 5432,
    username: 'postgres',
    password: 'admin',
    database:"app-store",
    entities: [],
    // entities: ["dist/**/*.entity{.ts,.js}"],
    synchronize: true,
};

export default config;