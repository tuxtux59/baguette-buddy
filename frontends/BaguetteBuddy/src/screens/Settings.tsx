import React from 'react';
import { SafeAreaView, ScrollView } from 'react-native';
import { Button, Divider, List, Text, TextInput } from 'react-native-paper';
import { useBaguetteBuddy } from '../contexts/BaguetteBuddyProvider';

const Settings = ({ }): React.JSX.Element => {
  const { setUser } = useBaguetteBuddy();

  return (
    <SafeAreaView>
      <ScrollView style={{ padding: 4 }}>
        <Text variant="headlineMedium">Settings</Text>
        <List.Section>
          <List.Subheader>Server credentials</List.Subheader>
          <TextInput
            label="server URL"
            mode="outlined"
            placeholder="https://mybaguette-buddy.url"
            style={{ marginHorizontal: 12 }}
            right={<TextInput.Icon icon="web" />}
          />
          <Divider style={{ marginVertical: 8, marginHorizontal: 12 }} />
        </List.Section>
        <Button
          onPress={() => setUser(null)}
          rippleColor="red"
          textColor="red"
        >
          Logout
        </Button >
      </ScrollView>
    </SafeAreaView>
  );
};

export default Settings;

