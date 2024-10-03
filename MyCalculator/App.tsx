import { useState } from "react";
import { StatusBar as ExpoStatusBar } from "expo-status-bar";
import { SafeAreaView, StatusBar, StyleSheet, Switch } from "react-native";
import { myColors } from "./src/styles/Colors";
import MyKeyboard from "./src/components/Keyboard";
import { ThemeContext } from "./src/context/ThemeContext";

export default function App() {
  const [theme, setTheme] = useState("light");
  return (
    <ThemeContext.Provider value={theme}>
      <SafeAreaView
        style={
          theme === "light"
            ? styles.container
            : [styles.container, { backgroundColor: "black" }]
        }
      >
        <ExpoStatusBar
          backgroundColor={theme === "light" ? myColors.light : "black"}
          style={theme === "light" ? "dark" : "light"}
        />
        <Switch
          value={theme === "dark"}
          onValueChange={() => setTheme(theme === "light" ? "dark" : "light")}
        />
        <MyKeyboard />
      </SafeAreaView>
    </ThemeContext.Provider>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: myColors.light,
    alignItems: "center",
    justifyContent: "flex-start",
    marginTop: StatusBar.currentHeight,
  },
});
