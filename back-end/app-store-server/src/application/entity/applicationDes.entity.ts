import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ name: 'app-des' })
export class ApplicationDesEntity {
  @Column()
  id: number;
  @PrimaryGeneratedColumn()
  app_id: number;
  @Column()
  track_name: string;
  @Column()
  size_bytes: string;
  @Column()
  app_desc: string;
}
