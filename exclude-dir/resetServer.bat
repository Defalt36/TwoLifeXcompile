@echo off
echo
echo "Deleting server files..."

cd /d %~dp0

del biome.db eve.db floor.db floorTime.db grave.db lookTime.db map.db mapTime.db meta.db playerStats.db
del biomeRandSeed.txt familyDataLog.txt log.txt recentPlacements.txt testMapStale.txt
del mapDummyRecall.txt shutdownLongLineagePos.txt lastEveLocation.txt

timeout 3
