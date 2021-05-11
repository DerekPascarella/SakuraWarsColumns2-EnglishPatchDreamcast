Sakura Wars: Columns 2 (Hanagumi Taisen Columns 2)
English Translation v1.1
Sega Dreamcast

Project Page:
https://github.com/DerekPascarella/SakuraWarsColumns2-EnglishPatchDreamcast


.------------------::[ Credits ]::------------------
|
| LEAD DEVELOPER / PROJECT LEAD:
| Derek Pascarella (ateam)
|
| TRANSLATION COORDINATOR:
| Chanh Nguyen (Burntends)
|
| LEAD TRANSLATORS:
| Chanh Nguyen        Natsume38
| Danthrax4
|
| MAIN TECHNICAL ASSISTANCE:
| HaydenKow           esperknight
| VincentNL           nanashi
|
| MISCELLANEOUS TECHNICAL ASSISTANCE:
| SnowyAria           NoahSteam
| TurnipTheBeet       YZB
|
| MISCELLANEOUS TRANSLATION ASSISTANCE:
| cj_iwakura          Ozaline
| SnowyAria           Matatabi Mitsu
| ItsumoKnight        Samantha Ferreira
| LettuceKitteh       JoblessFloppy
|
| GRAPHICS:
| Derek Pascarella (ateam)
|
| MISCELLANEOUS GRAPHICS ASSISTANCE:
| GriffithVIII        Patrick Traynor
| AnimatedAF          Small Nerd
| Einahpets           Danthrax4
|
`---------------------------------------------------


.-----------::[ Patching Instructions ]::-----------
|
| TOSEC GDI SOURCE:
| Hanagumi Taisen Columns 2 v1.000 (1999)(Sega)(JP)[!].zip
|
| Note that due to the way my custom patching utility works, checksums are not a
| necessary form of patch validation.  Instead, this utility will always work with
| any TOSEC-style GDI containing a .GDI file along with two .BINs and a .RAW file.
|
| 1) Open the "Sakura Wars - Columns 2 (Engish Translation Patcher Utility).exe"
|    program.
|
| 2) Click "Select GDI" and then select the TOSEC-style source GDI to be patched.
|    Note that the original GDI will not be modified during the patching process.
|
| 3) Click "Apply Patch", which will create a copy of the original GDI and then
|    apply the patch to it.
|
| 4) Once the process has completed, the newly patched GDI will be in the
|    "patched_gdi" folder and ready for use.
|
`---------------------------------------------------


.------------::[ v1.1 Release Notes ]::-------------
|
| First of all, let me start off by saying that the positive reaction to the
| release of this patch has been incredible!  I can't begin to explain the
| joy and satisfaction I feel when I see how many people are enjoying the hard
| work that me and my team put into making this English translation of "Sakura
| Wars: Columns 2" a reality.
|
| All of that being said, I knew that even after all of the testing by me and
| others, there was a very high likelihood that some issues would be identified
| once this patch was released in the wild.  Well, I was right.  However, funny
| enough, almost all of the fixes in this v1.1 release address problems that I
| myself identified!  Rest assured that these fixes are mostly typo corrections
| and style improvements, so the v1.0 patch is still stable and solid.
|
| More specifically, the fixes in this release include:
|
|   -> Correcting a misaligned LIPS response entry in Kayama's story.
|   -> Correcting two typos in Kayama's story.
|   -> Correcting a typo in Sumire's story.
|   -> Correcting a typo in Maria's story.
|   -> Correcting a typo with Orihime's last name in the credits.
|   -> Improving the labeling for spirit level and time-limit in puzzle-solving
|      scenarios, where "SPIRIT DEFENSE XX%" has become "SPIRIT POWER XX%" and
|      "T. LIMIT DEFENSE +XXs" has become "TIME ASSIST +XXs", both of which more
|      accurately describe what these stats represent.
|   -> Improving the spacing of the "POWER BOOST!" and "W.D." labels for the
|      stats seen in puzzle-solving scenarios.
|   -> Fixing a bug in my custom patching utility (now at v0.2).
|   -> Adding an English error message that is displayed when attempting to
|      download the included DLC or 100% unlocked save when modem/BBA issues are
|      preventing the successful launch of the built-in web browser.
|
| To add some clarity to the last item on the above list, there exists certain
| conditions under which the game's built-in web browser fails to launch.  Even
| though the game in no way makes an outbound connection to the Internet in order
| to retrieve the bundled DLC or 100% unlocked save, a sanity check of sorts
| will prevent the browser from launching.  On original hardware, this failure
| occurs when no modem or broadband adapter (BBA) is present, or if either of the
| two is damaged.  In an emulator, this failure occurs when the modem or BBA is
| not being emulated in the same way that other peripherals are, like the VMU.
|
| Being that Dreamcast modems are still holding up strongly to this day, I
| currently have no plans to reverse-engineer the routine that performs this
| sanity check.  However, since a few emulator users have reported this issue, I
| will state here that I have successfully tested RetroArch+FlyCast with the HLE
| BIOS option enabled.  So far, I have not been able to achieve this functionality
| with NullDC or ReDream.
|
| That being said, I managed to create VMU files compatible with both NullDC and
| ReDream that are available in the "vmu_files\emulators" folder found within this
| patch.  These files can be placed in the root emulator folder and renamed to use
| whichever VMU port you choose.  Note that these are not individual saves, but
| are instead files that represent the entire contents of an emulated VMU.
| Therefore, be sure not to overwrite your existing VMU files containing valuable
| saves.
|
| For those with other methods of transferring individual files to a VMU, either
| on original hardware or via emulation, I have included the individual VMI/VMS
| files for the DLC and 100% unlocked save in the "vmu_files" folder found within
| this patch.
|
| For the curious, there was also a bug report submitted to GitHub pointing out
| some graphical corruption with one of the DLC puzzles:
|
|   -> https://bit.ly/3f5CEWa
|
| Interestingly enough, this bug actually also affects the original, unpatched
| game.  Since this issue never appears anywhere outside of one or two DLC
| puzzles, and because it also affects the original game, I have opted not to
| spend time trying to reverse-engineer and fix it.
|
| Last thing to note is an edge-case bug that was found with my custom patching
| utility:
|
|   -> https://bit.ly/3nY574f
|
| I managed to solve the issue, and it was the result of the gditools CLI
| utility having some of the strangest behavior of anything I've ever worked
| with.  In all fairness, it may not be the application's fault, but instead a
| quirk of the bundled-up executable with the built-in Python interpreter and its
| affect on Windows file paths as part of command parameters.  Either way, it's
| been solved, and my custom patching utility is now at version 0.2.  This brings
| me one step closer to providing the Dreamcast scene with a universal patcher!
|
| In closing, I'd like to give a special thanks to the following content creators
| for featuring our project in their blogs, videos, and podcasts:
|
|   -> The Dreamcast Junkyard
|        -https://bit.ly/3vR849x (article)
|
|   -> SEGAbits
|        -https://bit.ly/3w5dAWv (article)
|        -https://bit.ly/3nYsNFJ (trailer video)
|
|   -> SHIRO!
|        -https://bit.ly/3h8MrgY (article)
|        -https://bit.ly/3o1rshi (article)
|        -https://bit.ly/3bd3OcH (video)
|        -https://bit.ly/3etmlU4 (video)
|
|   -> Combat Revue Review
|        -https://bit.ly/3evfkSL (article)
|
|   -> SEGA Driven
|        -https://bit.ly/3bd3Dhx (article
|
|   -> Otaku Freaks
|        -https://bit.ly/3ex4viU (article)
|
|   -> Found in Fanslation Podcast
|        -https://bit.ly/2RGBfh2 (podcast)
|
`---------------------------------------------------


.------------::[ v1.0 Release Notes ]::-------------
|
| It is with extreme pride and excitement that I present to you the v1.0 
| release of our English translation patch for "Sakura Wars: Columns 2" (known 
| in Japanese as "Hanagumi Taisen Columns 2") for the Sega Dreamcast!  This 
| patch comes to you all, the wonderful members of the Dreamcast community, as 
| 100% complete.  Aside from hiring new voice actors to re-record the original 
| Japanese, and aside from the online battle section (which I'll be happy to
| translate if the protocol is ever reverse-engineered), no stone was left
| unturned.  Everything from start to finish is fully translated and localized.
| On top of that, the original website, the original DLC, and even a fully
| complete/unlocked save, are all accessible from directly within the game itself
| (read on for more details).
| 
| For those unaware, this is an extremely in-depth and full-featured puzzle 
| game based on the world of "Sakura Wars."  Not only does it feature a myriad 
| of unlockable content and extra bonus material, but also includes a full 
| "Story" mode for all 12 playable characters.  For those like me who love good 
| puzzle games, "Sakura Wars: Columns 2" not only delivers in the department of 
| fun gameplay, but also keeps on giving back to the player with a multitude of 
| different ways to enjoy the game.
| 
| Unlike most Japanese-exclusive titles, "Sakura Wars: Columns 2" is unique in 
| that, without this patch, each and every piece of text, whether it be rendered 
| during a dialog scene or as part of an image, is in Japanese.  The one and 
| only English phrase that previously existed was "PRESS START BUTTON" on the 
| title screen.  For what must be the most text heavy puzzle game of all time, 
| this is saying quite a lot about the level of effort involved in making this 
| translation patch a reality.  My goal from the start was to produce something 
| that felt as close to an official, fully localized English Dreamcast game as 
| possible.  If you ask me, we achieved that.
|
| Given that literally everything you see in English is the result of this patch,
| it may be a bit tough to thoroughly list each aspect of the game that's been
| modified and translated.  However, I thought I'd at least try:
|
|   -> All VMU icons have been translated from Japanese to English, including the
|      main logo.
|   -> Save games will be stored on the VMU with English labels and descriptions,
|      which are visible from the Dreamcast's VMU manager.  Note that this is
|      also true of the bundled DLC.
|   -> The main logo appearing on the title screen has been redone in English.
|   -> All menus have been translated from Japanese to English, including the VMU
|      save manager, the main menus, the options menu, and the in-game menus.
|   -> The built-in web browser has been (partially) translated from Japanese to
|      English and now points to a custom English landing page that contains links
|      to the DLC and a fully complete/unlocked save.
|   -> The "Extras" section content has been fully translated from Japanese to
|      English.
|   -> All "Story" mode scripts have been fully translated from Japanese to
|      English, including LIPS responses and title screens.
|   -> The introduction text for "Shonen Red" and "Director!" modes has been
|      translated from Japanese to English.
|   -> Whenever spoken Japanese dialog occurs, the image displayed will contain
|      subtitles or manga-style speech bubbles in English.
|   -> All character profile images have had their English names added.
|   -> All images containing Japanese text that appear in the ending sequences
|      for "Shonen Red" and "Director!" modes have been translated into English.
|   -> All rank-up messages and puzzle description text has been translated from
|      Japanese to English in both "Puzzle Variety" modes ("Puzzle Challenges"
|      and "Load Puzzle From VMU" options).
|   -> All combat-style icons (e.g. Fire, Shadow, Thunder, Wind, etc.) have been
|      translated from Japanese to English with brand new icons created just for
|      this patch.
|   -> All text and images containing Japanese has been translated to English for
|      everything seen during puzzle matches, such as character status messages,
|      challenge messages, attack options, HUD labels, and more.
|   -> The ending credits seen after beating "Story" mode with a character have
|      been translated from Japanese to English and also now include the names and
|      roles of the translation patch team.
|   -> Even though its half-width and not variable-width, the Latin character font
|      sheet has been cleaned up for better aesthetics, including the addition of
|      the accented "è" used when Iris calls Ogami "Mon Frère," and the accented
|      "ó" used when Kayama says "Adiós."
|   -> The trailer FMV shown in attract mode has been subtitled in English.
|   -> VGA mode has been enabled, which mainly helps those who will be playing this
|      patched game via CDI (i.e. burned disc), as all ODE solutions already have
|      on-the-fly VGA patching.
|
| As is plain to see, this was quite an extensive undertaking.  It's also highly
| likely that I accidentally left something off that list, which is why it may
| just be better to say "Everything was translated!"
| 
| Speaking of extensive undertakings; compared to the previous two Dreamcast
| patches I did ("Neon Genesis  Evangelion: Typing Project E" and "Taxi 2"), this
| was much more of a group effort, so much so that I have difficulty in even using
| the words "my patch" when describing it.  Because of the varied contributions of
| the core group, as well as many others, this release is as polished, complete,
| and awesome as it deserves to be.
| 
| Other than the technical contributors listed later in these notes, the core 
| group that helped make this translation patch possible are as follows:
|
|   -> Chanh Nguyen (Burntends) served as the project's Translation Coordinator, 
|      as well as one of the Lead Translators.  He was eager to start helping
|      with this project and was the very first person to volunteer.  Not only
|      was he integral in assembling a translation team, but also in his
|      knowledge of  "Sakura Wars" lore so that the patch would have the proper
|      tone and feeling. He also served as Editor, making certain that grammar
|      and spelling was accurate, while also giving the final sign-off for the
|      various drafts that the script went through to ensure a consistent level
|      of quality.  You can find him on Twitter as @burntends2.
|
|   -> Nastume38 had the role of a Lead Translator.  She has the strongest
|      Japanese language skills out of the group and thus was an essential piece
|      of the puzzle.  She worked diligently to translate hundreds upon hundreds
|      of lines of text, match them up with recorded game footage, map out the
|      LIPS responses, and offer up many fantastic takes on localizing Japanese
|      humor and expressions.  You can find her on Twitter as @blaster_mania.
|
|   -> Danthrax4 assisted the project in the capacity of a Lead Translator.  He 
|      caught my attention after his work with nanashi on the "Cotton 2: Magical 
|      Night Dreams" English translation patch for the Sega Saturn.  While he
|      joined our project in its latter third or so, he came to us with a
|      fantastic background as an editor in the newspaper industry.  His
|      suggestions and decisions surrounding both style and form of our English
|      text went a long way to give the game the almost-official feeling that I 
|      was aiming for.  He is also responsible for the awesome custom logo you
|      see on your VMU while playing this game!  You can find him on Twitter as
|      @Danbo_4.
| 
| Others who aided translation in various ways, whether it be by identifying 
| Kanji characters, or by helping to properly translate/localize various 
| aspects of "Sakura Wars" lore, and everything in between, are cj_iwakura, 
| Ozaline, SnowyAria, Matabi Mitsu, ItsumoKnight, Samantha Ferreira, 
| LettuceKitteh, and JoblessFloppy.
| 
| From a technical perspective, this game presented many challenges.  Being the 
| Project Lead and Lead Developer meant that I was solely responsible for 
| making sure that all translated text and images successfully made their way 
| back into the game to replace the original Japanese equivalents.  However, 
| such a large portion of my work would not have been possible without the 
| fantastic efforts of other programmers and ROM hackers.
| 
| Not only were there esoteric file formats to reverse-engineer (e.g. binary 
| containers holding important assets), but also a form of file compression 
| that kept some of the most important game data locked away and inaccessible
| without some very hacky workarounds I developed.  The format of the Japanese
| text used in "Story" mode was even a hurdle to  overcome!  However, there is
| no mountain too high that hard work and perseverance cannot scale it.
| 
| For their technical contributions, I would like to thank the following 
| individuals:
|
|   -> HaydenKow for the tool he wrote to combine a PVR and PVP combination and 
|      convert them into a properly indexed PNG, which allowed me to modify such 
|      images and then convert them back to a PVR/PVP combo. with the color
|      palette in-tact.
|
|   -> esperknight for not only helping me determine the formatting of the binary 
|      container files used in this game, but also for taking time to write a
|      custom tool to extract/rebuild them in a much simpler way than I was
|      previously doing it.
|
|   -> nanashi for reverse-engineering the compression algorithm used for many 
|      key assets and then also writing a tool to perform the decompression of
|      said files.  He also later identified the compression algorithm, which we 
|      previously thought was something proprietary created by the game
|      developers.
|
|   -> VinecntNL for his tips on dumping raw PVR textures using FlyCast, which 
|      helped me develop the method I used to obtain original images for my early 
|      "trial and error" method of replacing compressed images with my own
|      modified and uncompressed ones.
| 
| Additionally, I'd like to thank SnowyAria, TurnipTheBeet, NoahSteam, and 
| YZB for their miscellaneous tips and tricks along the way.
| 
| Other categories where assistance was so graciously given to our project 
| include graphics/video and testing.  While I personally did the majority of the 
| graphics myself, I want to thank the following individuals for their 
| invaluable contributions:
|
|   -> GriffithVIII for his beautiful, stylized text used before and after a
|      match starts, such as "SHONEN RED SCRAMBLE!", "NEW RECORD!", and 
|      "GAME OVER."
|
|   -> Einahpets and Small Nerd for the custom English logo seen not only on the
|      game's title screen, but also on the disc art PVR that users of 
|      GDEMU+GDMenu will see.  They also created the custom cover art that is
|      included with this release.
|
|   -> AnimatedAF for doing the awesome, manga-style speech bubbles for the 
|      images seen in the ending sequences for "Shonen Red" and "Director!"
|      modes, as well as the background image with the repeating logo used for
|      the "LOADING" screen.
|
|   -> Patrick "TraynoCo" Traynor for subtitling the trailer FMV that plays
|      during attract mode.
| 
| For game testing, both myself and Chanh Nguyen (Burntends) did the majority of
| the playthroughs, but I still want to acknowledge the early assistance from two
| well-known "Columns" experts: Trevgauntlet Neu and RoyTheDragon.
|
| In terms of "known issues" or current limitations with this v1.0 release of
| our English translation patch, presently there is only one.  Similarly to the
| initial release of "Sakura Wars" for the Sega Saturn, the lip movement for
| on-screen characters in "Story" mode is currently nonfunctional.  While I did
| develop a method for restoring lip movements, it ended up only being a partial
| solution and fell short in several cases where limited space is available in
| memory for storing English text.
|
| On this topic, I actually spoke several times with NoahSteam, the lead developer
| on the "Sakura Wars" Sega Saturn project, regarding the method he used for their
| team's upcoming patch update, which, among other things, restores lip movement.
| Unfortunately, "Sakura Wars: Columns 2" does not follow the same format as the
| earlier Saturn game.  Still, his method employs essentially the same concept as
| the one I devised.  I'm happy to know that he was able to implement this
| improvement in his patch.  Perhaps one day in the future I will revisit this
| topic and develop a method that suites this game, as well.
| 
| The last important tidbit to know about this release is that I included with 
| it a cached version of the original website, the three original DLC puzzles, 
| and a fully complete/unlocked save, all of which are accessible from directly 
| within the game.  The original website is actually still archived and hosted 
| on the official "Sakura Wars" website, so deciding to include it was a 
| no-brainer for me.  Similarly, it makes perfect sense why I would want to 
| include the original DLC, too (thank you to DreamcastLive.net for continuing 
| to host Dreamcast DLC).  However, some may wonder why I'd want to include a 
| complete game save, rather than force players to grind away and hone their 
| skills in order to enjoy the plethora of amazing unlockable content.  Well, 
| firstly, I'm not that sinister, and secondly, I wanted players to be able to 
| experience and enjoy all of the incredible things that "Sakura Wars: Columns 
| 2" has to offer.  Perhaps my motives are slightly selfish, but it felt wrong 
| to work so hard on this game only to have players see and experience half of 
| it.
| 
| To access this VMU content, go to the "ONLINE" entry on the main menu and 
| then select "WEBSITE AND DLC."  From there, the Japanese DreamPassport web 
| browser will launch, which I partially translated in order to make navigating 
| this section easier.  Once the browser launches, select the "Exit" button at 
| the top-left of the screen.  You'll then be presented with a custom landing 
| page I created which includes links to all three DLC puzzles, a fully 
| complete/unlocked save, and a cached version of the original Japanese 
| website.  To copy the DLC or the save to your VMU, simply click on the 
| respective link with the "A" button and then select the VMU onto which the 
| file should be written.
|
| Once you've downloaded all of the desired files to your VMU, you can exit the
| browser by pressing the "L" button and then selecting the last option on the
| bottom of the menu that appears.  If you view these save files in the
| Dreamcast's home screen menu, you'll notice that all of their names and labels
| appear in English, too!
| 
| In summary, if you've made it this far in the release notes, let me end by 
| thanking you on behalf of the entire team.  The Dreamcast itself has given me 
| many, many years of joy, and the incredible community that has continued to 
| live on remains a huge part of my life today.  I gave over 200 hours of my
| time to complete this translation patch and truthfully, I would do it all
| again.  Giving back to the community is a pleasure and privilege.  I may never
| be able to accurately distill down and put into words what Sega's swansong
| console means to me, but something tells me that if you've downloaded this
| patch, you just might already know how I feel.
| 
| Keep Dreaming, my friends...
|
| PS: All custom tools developed by me and other technical contributors for this
|     patch are available with permission in this project's GitHub repository.
|
`---------------------------------------------------


.-----------------::[ Changelog ]::-----------------
|
| -> 2021-05-11 (v1.1)
|      -Fixed misaligned LIPS response in Kayama's story.
|      -Fixed two typos in Kayama's story.
|      -Fixed typo in Sumire's story.
|      -Fixed typo in Maria's story.
|      -Fixed typo with Orihime's last name in the credits.
|      -Improved labeling for status in puzzle-solving scenarios.
|      -Added custom English error message for modem/BBA issues that prevent DLC
|       and save file downloading.
|      -Fixed a bug in the custom patcher (now at v0.2).
|
| -> 2021-05-03 (v1.0)
|      -Initial release.
|
`---------------------------------------------------


Find me on...
 -> SegaXtreme: https://segaxtreme.net/members/ubik.21655/
 -> Dreamcast-Talk: https://www.dreamcast-talk.com/forum/memberlist.php?mode=viewprofile&u=5766
 -> GitHub: https://github.com/DerekPascarella
 -> Twitter: https://twitter.com/DerekPascarella
 -> Reddit: https://www.reddit.com/user/ate4m/
 -> YouTube: https://www.youtube.com/channel/UCLLjIeHSQbBLEooQ83SrdfQ