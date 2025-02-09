import React from 'react';

import { NavigationContainer } from '@react-navigation/native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { BaguetteBuddyProvider } from './src/contexts/BaguetteBuddyProvider';
import MainStack from './src/navigations/MainStack';

function App(): React.JSX.Element {
  const Tab = createBottomTabNavigator();
  const Stack = createNativeStackNavigator();

  return (
    <NavigationContainer>
      <BaguetteBuddyProvider>
        <MainStack Stack={Stack} Tab={Tab} />
      </BaguetteBuddyProvider>
    </NavigationContainer>
  );
}

export default App;

