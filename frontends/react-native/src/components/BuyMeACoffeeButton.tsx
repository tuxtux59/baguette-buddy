import React, { useCallback } from 'react';
import { Image, Linking } from 'react-native';
import { Button, Text } from 'react-native-paper';
import { SvgUri } from 'react-native-svg';

const BuyMeACoffeeButton = (): React.JSX.Element => {
  const url = 'https://buymeacoffee.com/tiboreno';
  const handlePress = useCallback(async () => {
    await Linking.openURL(url);
  }, [url]);

  return (
    <Button
      onPress={handlePress}
      buttonColor="#FFDD00"
      textColor="#fff"
    >
      <SvgUri uri="https://cdn.buymeacoffee.com/buttons/bmc-new-btn-logo.svg" />
      <Text>Buy me a coffee</Text>
    </Button>
  );
};

export default BuyMeACoffeeButton;
