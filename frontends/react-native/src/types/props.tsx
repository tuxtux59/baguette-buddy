import { TypedNavigator } from '@react-navigation/native';
import { Receipe } from './api';

export type ReceipeCardProps = {
  receipe: Receipe;
}

export type ShowProps = {
  receipe?: Receipe;
  route: any;
}

export type IndexProps = {
  backgroundStyle?: any;
}


export type MainStackTypeProps = {
  Stack: TypedNavigator<any>;
  Tab: TypedNavigator<any>;
}