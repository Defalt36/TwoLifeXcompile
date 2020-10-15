cd ../../OneLife/server

echo
echo "Warning: There is no going back."

read userIn

rm -v biome.db eve.db floor.db floorTime.db grave.db lookTime.db map.db mapTime.db meta.db playerStats.db
rm -v mapDummyRecall.txt shutdownLongLineagePos.txt lastEveLocation.txt

echo 1 > testMapStale.txt

echo "done."
