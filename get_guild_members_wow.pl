#!/usr/bin/perl -w

###############################################
#This script will connect to the wowarmory.com#
#site and display level and name of members   #
#of a particular guild.                       #
###############################################

# Load required modules.
use strict;
use Games::WoW::Armory;
use FileHandle;

#declare variables
my @name;
my @race;
my @level;
my @guild;
my @gender;
my @faction;
my @lmodified;
my @class;

# Create new Games::Wow::Armory object.
my $armory = Games::WoW::Armory->new();
$armory->search_character( { realm     => 'anvilmar',
                             character => 'draxxus',
                             country   => 'US' } );

#set characteristic to it's corresponding array
@name = $armory->character->name;
@race = $armory->character->race;
@level = $armory->character->level;
@guild = $armory->character->guildName;
@gender = $armory->character->gender;
@faction = $armory->character->faction;
@lmodified = $armory->character->lastModified;
@class = $armory->character->class;

#get guild members
my $armory2 = Games::WoW::Armory->new();
$armory2->search_guild( { realm         => 'anvilmar',
                          guild         => "@guild",
                          country       => 'US' } );

#open file handle and write character stats
my $fh = new FileHandle;
        if ($fh->open("> guild.csv")) {

# Print Character's stats.
        foreach my $member (@{$armory2->guild->members}){
        my @members = $member->name;
        print $fh $member->name;
        print $fh ",";
        print $fh $member->level;
        print $fh ",\n";
                }
        }
$fh->close;
