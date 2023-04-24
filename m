Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E8A6D6ABF
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Apr 2023 19:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjDDRh4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-mmc@lfdr.de>); Tue, 4 Apr 2023 13:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbjDDRhy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Apr 2023 13:37:54 -0400
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BBC5B81
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 10:37:32 -0700 (PDT)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id CDCFD3A2A31
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 19:32:59 +0200 (CEST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id B67C33A2A2D
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 19:32:59 +0200 (CEST)
X-TM-AS-ERS: 10.181.10.103-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgxLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx1.dmz.swissbit.com (mx1.dmz.swissbit.com [10.181.10.103])
        by mail5.swissbit.com (Postfix) with ESMTPS
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 19:32:59 +0200 (CEST)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Dominik 'Rathann' Mierzejewski <dominik@greysector.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: mmc-utils: ioctl connection timed out with SD cards
Thread-Topic: mmc-utils: ioctl connection timed out with SD cards
Thread-Index: AQHZZlWz7zj1vli6ykWT5I70wuFTRa8aAk7wgADKbgCAAJuv0A==
Date:   Tue, 4 Apr 2023 17:32:57 +0000
Message-ID: <0dc45f7ba447445e946d8f71e63f3f3e@hyperstone.com>
References: <ZCsSHxDv+158emk5@sakura.greysector.net>
 <597389cd8b21409aa7015d08aa4a804d@hyperstone.com>
 <ZCv3OBCE1hB32CDI@sakura.greysector.net>
In-Reply-To: <ZCv3OBCE1hB32CDI@sakura.greysector.net>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27546.002
X-TMASE-Result: 10--15.415700-10.000000
X-TMASE-MatchedRID: 9M69yBZ2Ml7UL3YCMmnG4qwNPl5dbX19NZEftOVQtYYoiFyh1jyXYXw6
        H06bMgivhieSSn7XJN2nhIHSnJCHA1QzWHuBi8IiqdwbW9Wx9tAOPDBPSvoRdNbZhgeyVPQjkxO
        lHsprLcWRXJNeRN9of3ZWOyUgDPdGQ8+LSipOfwSsxn4GpC3Y2hmyTBaqiJvcuqWf6Nh7tmH8vi
        H5LwNzLI4clpDJUSJwy/bRptJBlDOYhQrvmnrzTjz6L+U/pejxUrr7Qc5WhKieEPi9wVyFrszJv
        WtAME7u84NB8AEyFvqgveaxmg8syGMASGES4oP2kbMiEOIxZetxNNbSm9qwEd2VQFX+cuxScnRq
        1hEHwGLQaDUO2JoApf0o/1pwjPyzaDAi8sBNMoELbigRnpKlKT4yqD4LKu3A
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 8e2c0a61-7a25-4939-ac14-e71349be5894-0-0-200-0
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The problem is the harcoded 0x0001 as RCA, sdcards have whatever the vendor thinks is right.
I can send a fix for that tomorrow, but generally mmc-utils isn't much useful for SD cards, most mmc-utils features are eMMC-only features anyway.
Softreset works as expected, for byte-addressed we can use grouped wp.
I was thinking about adding TMP_WRITE_PROTECT for both, maybe unlock, too.
And also adapt erase.
Apart from that do you have any features that you can think of?
SD just doesn't have that many features that are used outside of normal IO operation.
Another candidate would be FULE, but cards that support it are rare.

Regards,
Christian

-----Original Message-----
From: Dominik 'Rathann' Mierzejewski <dominik@greysector.net> 
Sent: Tuesday, April 4, 2023 12:09 PM
To: linux-mmc@vger.kernel.org
Subject: Re: mmc-utils: ioctl connection timed out with SD cards

On Monday, 03 April 2023 at 22:11, Christian L�hle wrote:
> >Hello,
> >is the mmc tool from mmc-utils supposed to work with SD cards?
> Not really no, but status get is pretty much the one thing that should 
> work, apart from register reads that don't issue anything.

I see. I thought any /dev/mmcblk? device would be supported. The documentation doesn't make this clear. :)

> I'm using RK3399 on SD too and it works okay for me, will try updating 
> tomorrow.
> Could you show the debug prints to see the mmc command / responses?
> Ideally for anything in mmc/core

Will something like:

# alias ddcmd='echo $* > /proc/dynamic_debug/control'
# ddcmd 'module mmc_core +p'
# ddcmd 'module rtsx_pci_sdmmc +p'
# mmc status get /dev/mmcblk0
# dmesg | grep -E 'mmc_core|rtsx_pci_sdmmc'

suffice?

Regards,
Dominik
-- 
Fedora   https://getfedora.org  |  RPM Fusion  http://rpmfusion.org
There should be a science of discontent. People need hard times and oppression to develop psychic muscles.
        -- from "Collected Sayings of Muad'Dib" by the Princess Irulan

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

