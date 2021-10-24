import { ApplicationEntity } from "./src/application/entity/application.entity";
import { ApplicationDesEntity } from "./src/application/entity/applicationDes.entity";
import { ConnectionOptions } from "typeorm";

const config : ConnectionOptions = {
    type: 'postgres',
    host: 'localhost',
    port: 5432,
    username: 'postgres',
    password: 'admin',
    database:"app-store",
    entities: [ApplicationDesEntity,ApplicationEntity],
    // entities: ["dist/**/*.entity{.ts,.js}"],
    synchronize: true,
};

export default config;