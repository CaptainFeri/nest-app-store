import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ApplicationModule } from './application/application.module';
import ormConfig from '../ormConfig';

@Module({
  imports: [TypeOrmModule.forRoot(ormConfig), ApplicationModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
