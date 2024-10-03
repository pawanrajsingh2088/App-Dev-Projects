import { View, Text, StyleSheet, SafeAreaView } from "react-native";
import React from "react";
import Keyboard from "../components/Keyboard";

const HomeScreen = () => {
  return (
    <View style={styles.container}>
      <Keyboard />
    </View>
  );
};

export default HomeScreen;

const styles = StyleSheet.create({
  container: {
    flex: 1,
    width: "100%",
    paddingHorizontal: 8,
  },
});
