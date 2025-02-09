import React from 'react';
import Index from '../screens/Index';
import { tabIconValue } from '../utils/navigation';
import { useColorScheme } from 'react-native';
import { Colors } from 'react-native/Libraries/NewAppScreen';
import Cart from '../screens/Cart';
import Settings from '../screens/Settings';

const MyTabs = ({ Tab }) => {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
    height: '100%',
    padding: 2,
    flexGrow: 1,
  };

  return (
    <Tab.Navigator
      screenOptions={({ route }) => ({
        tabBarIcon: ({ focused, color }) => tabIconValue(route, focused, color),
        tabBarActiveTintColor: 'tomato',
        tabBarInactiveTintColor: 'gray',
        headerShown: false,
      })}
    >
      <Tab.Screen name={'receipes'}>
        {(props) => <Index backgroundStyle={backgroundStyle} />}
      </Tab.Screen>
      <Tab.Screen name="cart">
        {(props) => <Cart {...props} />}
      </Tab.Screen>
      <Tab.Screen name="settings">
        {(props) => <Settings {...props} />}
      </Tab.Screen>
    </Tab.Navigator>
  )
}

export default MyTabs;