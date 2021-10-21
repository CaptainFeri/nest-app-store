import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ name: 'applications' })
export class ApplicationEntity {
  @PrimaryGeneratedColumn()
  i: number;
  @Column({nullable:true})
  FIELD1: string;
  @Column({nullable:true})
  id: number;
  @Column({nullable:true})
  track_name: string;
  @Column({nullable:true})
  size_bytes: string;
  @Column({nullable:true})
  currency: string;
  @Column({nullable:true})
  price: string;
  @Column({nullable:true})
  rating_count_tot: string;
  @Column({nullable:true})
  rating_count_ver: string;
  @Column({nullable:true})
  user_rating: string;
  @Column({nullable:true})
  user_rating_var: string;
  @Column({nullable:true})
  ver: string;
  @Column({nullable:true})
  cont_rating: string;
  @Column({nullable:true})
  prime_genre: string;
  @Column({nullable:true})
  sup_devicesnum: string;
  @Column({nullable:true})
  ipadSc_urlsnum: string;
  @Column({nullable:true})
  langnum: string;
  @Column({nullable:true})
  vpp_lic: string;
}
