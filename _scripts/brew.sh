#!/bin/sh

echo "Update brew...";
brew update;

echo "Upgrade brew packages...";
brew upgrade;

echo "Clear old versions...";
brew cleanup -s;
