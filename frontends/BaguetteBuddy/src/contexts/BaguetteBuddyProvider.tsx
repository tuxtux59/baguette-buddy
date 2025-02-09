import React, { useContext, useEffect, useState } from 'react';
import { Receipe } from '../types/api';
import BaguetteBuddyContext from './BaguetteBuddyContext';
import { fetchReceipes } from '../services/api';
import { StyleSheet, useWindowDimensions } from 'react-native';
import { BaguetteBuddyContextType } from '../types/contexts';
import Login from '../screens/Login';

export const BaguetteBuddyProvider = ({ children }) => {
  const [receipes, setReceipes] = useState<Receipe[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState();
  const [user, setUser] = useState();
  const { width } = useWindowDimensions();
  const [markdownStyle, setMarkdownStyle] = useState<StyleSheet.NamedStyles<any> | undefined>();

  const refreshReceipes = () => {
    setLoading(true);
    fetchReceipes()
      .then((receps) => setReceipes(receps))
      .catch(err => setError(err))
      .finally(() => setLoading(false));
  };

  useEffect(() => {
    const styles = StyleSheet.create({
      ordered_list: {
        width: width * 0.88,
        paddingVertical: 5,
        marginHorizontal: 'auto',
      },
    });
    setMarkdownStyle(styles);
  }, [width]);

  useEffect(() => {
    user && refreshReceipes();
  }, [user]);

  const value: BaguetteBuddyContextType = {
    error,
    loading,
    refreshReceipes,
    receipes,
    width,
    markdownStyle,
    user,
    setUser,
  }

  return (
    <BaguetteBuddyContext.Provider value={value}>
      {user ? children : <Login />}
    </BaguetteBuddyContext.Provider>
  );
}

export const useBaguetteBuddy = () => {
  const context = useContext(BaguetteBuddyContext);

  if (context === undefined) {
    throw new Error('useBaguetteBuddy must be used inside a BaguetteBuddyProvider')
  }

  return context;
};
