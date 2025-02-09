import React from 'react';
import Show from '../screens/Show';
import MyTabs from './MyTabs';
import { MainStackTypeProps } from '../types/props';

const MainStack = ({ Stack, Tab }: MainStackTypeProps) => (
  <Stack.Navigator screenOptions={({ route }) => ({
    headerShown: route.name === 'show',
    headerTransparent: true,
    headerTintColor: 'white',
  })
  }>
    <Stack.Screen name="Tabs">
      {(props) => <MyTabs {...props} Tab={Tab} />}
    </Stack.Screen>
    <Stack.Screen
      name="show"
      options={({ route }) => ({
        title: route.params.receipe.title,
      }
      )}
    >
      {(props) => <Show {...props} />}
    </Stack.Screen>
  </Stack.Navigator>
);

export default MainStack;
