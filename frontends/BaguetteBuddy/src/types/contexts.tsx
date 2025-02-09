import { StyleSheet } from 'react-native';
import { Receipe } from './api';

export type BaguetteBuddyContextType = {
  loading: boolean,
  receipes: Receipe[],
  refreshReceipes: () => void,
  error: any,
  width: number | null,
  markdownStyle: StyleSheet.NamedStyles<any> | undefined;
  user?: any;
  setUser?: any;
}

