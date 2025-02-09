import { createContext } from 'react';
import { BaguetteBuddyContextType } from '../types/contexts';

const defaultContextValue: BaguetteBuddyContextType = {
  loading: false,
  receipes: [],
  refreshReceipes: () => null,
  error: undefined,
  width: 250,
  markdownStyle: undefined,
};

const BaguetteBuddyContext = createContext(defaultContextValue);

export default BaguetteBuddyContext;

