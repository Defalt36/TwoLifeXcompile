cd ../OneLife/server

echo
echo "Warning: There is no going back."

read userIn

rm -v biome.db eve.db floor.db floorTime.db grave.db lookTime.db map.db mapTime.db meta.db playerStats.db
rm -v biomeRandSeed.txt familyDataLog.txt log.txt recentPlacements.txt testMapStale.txt
rm -v mapDummyRecall.txt shutdownLongLineagePos.txt lastEveLocation.txt

cd curseLog
find . -type f -name '*.txt' -exec rm -v {} +
cd ..
cd failureLog
find . -type f -name '*.txt' -exec rm -v {} +
cd ..
cd foodLog
find . -type f -name '*.txt' -exec rm -v {} +
cd ..
cd lifeLog
find . -type f -name '*.txt' -exec rm -v {} +
cd ..
cd mapChangeLogs
find . -type f -name '*.txt' -exec rm -v {} +
cd ..

echo "done."