import Ionicons from 'react-native-vector-icons/Ionicons';
import React from 'react';
import { ParamListBase, RouteProp } from '@react-navigation/native';
import { ColorValue } from 'react-native';

export type ScreenNames = 'receipes' | 'show' | 'cart' | 'settings' | 'login'

const tabIcons: Map<ScreenNames, string> = new Map([
  ['receipes', 'home'],
  ['show', 'receipt'],
  ['settings', 'settings'],
  ['cart', 'cart'],
]);


export const tabIconValue = (route: RouteProp<ParamListBase, string>, focused: boolean, color?: number | ColorValue) => {
  const routeName = route.name as ScreenNames;
  let iconName = 'help-outline';
  if (tabIcons.has(routeName)) {
    iconName = tabIcons.get(routeName) ?? 'help-outline';
  }
  if (iconName !== 'help-outline' && !focused) { iconName += '-outline'; }
  return <Ionicons name={iconName} size={16} color={color} />;
};