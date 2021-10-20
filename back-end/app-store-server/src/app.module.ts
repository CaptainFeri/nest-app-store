import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ApplicationModule } from './application/application.module';
import ormConfig from '../ormConfig';
import { ApplicationEntity } from './application/entity/application.entity';
import { ApplicationDesEntity } from './application/entity/applicationDes.entity';

@Module({
  imports: [
    TypeOrmModule.forRoot(ormConfig),
    ApplicationModule,
    ApplicationEntity,
    ApplicationDesEntity,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
