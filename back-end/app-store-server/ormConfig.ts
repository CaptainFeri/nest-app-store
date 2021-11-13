import { TypeOrmModuleOptions } from "@nestjs/typeorm";

const config : TypeOrmModuleOptions = {
    type: 'postgres',
    host: 'localhost',
    port: 5432,
    username: 'postgres',
    password: 'admin',
    database:"app-store",
    // entities: [ApplicationDesEntity,ApplicationEntity],
    entities: ["dist/**/*.entity{.ts,.js}"],
    synchronize: true,
};

export default config;