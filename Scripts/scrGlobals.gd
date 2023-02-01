extends Node

#Controllers
var gameSaveSlot = 0

#Player Vars
var classInt = -1; #Int to name ID: -1 = N/A, 0 = Assassin, 1 = Alchemist, 2 = Dualist, 3 = Paladin
var className = "";
var plrHP = 100;
var plrMaxStamina = 100;
var plrStamina = 100;
var plrStaminaRecharge = 0.5;
var plrStaminaRechargeDelay = 0;
var plrStaminaDelayTime = 120;
var baseDMG = 15;
