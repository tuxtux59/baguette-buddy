import React, { useEffect, useState } from 'react';
import { View } from 'react-native';
import { Button, HelperText, Text, TextInput } from 'react-native-paper';
import { useBaguetteBuddy } from '../contexts/BaguetteBuddyProvider';

type errorsType = {
  login?: string;
  serverURL?: string;
  password?: string;
}

const regex = new RegExp(/^(?:(?:https?|ftp):\/\/)?(?:www\.)?[a-z0-9-]+(?:\.[a-z0-9-]+)+[^\s]*$/i);

const Login = (): React.JSX.Element => {
  const [loginInProcess, setLoginInprocess] = useState(false);
  const [login, setLogin] = useState('');
  const [password, setPassword] = useState('');
  const [serverURL, setServerURL] = useState('');
  const [enabledForm, setEnabledprocess] = useState(false);
  const [focused, setFocused] = useState(false);
  const [errors, setErrors] = useState<errorsType>({
    serverURL: undefined,
    login: undefined,
    password: undefined,
  });
  const { setUser } = useBaguetteBuddy();

  const isValidHttpUrl = (val: string): boolean => {
    return regex.test(val);
  };

  const handleServerChange = (val: string) => {
    if (val.length > 1 && !(isValidHttpUrl(val))) {
      setErrors({ ...errors, serverURL: 'invalid URL' });
    } else {
      setErrors({ ...errors, serverURL: undefined });
    }
    setServerURL(val);
  };

  const handleLoginChange = (val: string) => {
    setLogin(val);
    if (val.length > 1 && val.length < 8) {
      setErrors({ ...errors, login: 'should be at least 8 chars long' });
    } else {
      setErrors({ ...errors, login: undefined });
    }
  };

  const handlePasswordChange = (val: string) => {
    setPassword(val);
    if (val.length > 1 && val.length < 8) {
      setErrors({ ...errors, password: 'should be at least 8 chars long' });
    } else {
      setErrors({ ...errors, password: undefined });
    }
  };

  const handleLogin = async () => {
    setLoginInprocess(true);
    setTimeout(() => {
      setLoginInprocess(false);
      setUser(login);
    }, 2000);
  };

  useEffect(() => {
    if (focused) {
      setEnabledprocess(Object.values(errors).every(e => e === undefined));
    } else {
      setEnabledprocess(false);
    }
  }, [errors, focused]);

  return (
    <View style={{ flex: 1, justifyContent: 'center', backgroundColor: 'orange', paddingLeft: '20%', paddingRight: '20%' }}>
      <Text>
        Login
      </Text>
      <TextInput
        mode='outlined'
        label="server URL"
        value={serverURL}
        inputMode="url"
        keyboardType="url"
        error={errors.serverURL !== undefined}
        style={{ height: 40 }}
        onChangeText={(val) => handleServerChange(val)} />
      {errors.serverURL && <HelperText type="error">
        {errors.serverURL}
      </HelperText>}
      <TextInput
        mode='outlined'
        label="login"
        value={login}
        autoComplete="email"
        error={errors.login !== undefined}
        style={{ height: 40 }}
        onChangeText={handleLoginChange} />
      {errors.login && <HelperText type="error">
        {errors.login}
      </HelperText>}
      <TextInput
        mode="outlined"
        label="password"
        value={password}
        secureTextEntry
        error={errors.password !== undefined}
        style={{ height: 40 }}
        onChangeText={handlePasswordChange} />
      {errors.password && <HelperText type="error">
        {errors.password}
      </HelperText>}
      <Button loading={loginInProcess} onPress={handleLogin}>
        Login
      </Button>
      <Text>{enabledForm ? 'henabled' : 'disabled'}</Text>
    </View>
  );
};

export default Login;
