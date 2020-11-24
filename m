Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F2E2C21F7
	for <lists+linux-mmc@lfdr.de>; Tue, 24 Nov 2020 10:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbgKXJnU (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 24 Nov 2020 04:43:20 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:49073 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgKXJnT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2020 04:43:19 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 21B9923E45;
        Tue, 24 Nov 2020 10:43:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606210995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lt6x/itJc1dXt2VhsUKeDxS7oj0ZsZ4Zcf2aw15O+B8=;
        b=N+Keib/coSaK8Jki8gD3bHy0+YJOWmpiUOa7ytTdKv4HU2ACYe2ZkarVmtxjfLF6ksnxVD
        +ulHDKM65Ez4iwgDgGA6SM6umDx3XCn5e3Z1ymtZsY3xJA0oVJYoEFbtAblU1kkXgz1vxn
        AeykY6b/URr2j2QvY5MuqPx/xCyanoQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Nov 2020 10:43:15 +0100
From:   Michael Walle <michael@walle.cc>
To:     "Y.b. Lu" <yangbo.lu@nxp.com>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
 controllers use fixed indices
In-Reply-To: <AM7PR04MB6885044C8AE85FE369285186F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <20201119155025.965941-1-vladimir.oltean@nxp.com>
 <AM7PR04MB688536E10A0B35D75A9F8F34F8FF0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201120093015.duel3yx63cbya77w@skbuf>
 <VI1PR04MB6896C22F6B304F365C3BA626F8FB0@VI1PR04MB6896.eurprd04.prod.outlook.com>
 <71a86b0fbc95892f8fd240e0919e7e23@walle.cc>
 <AM7PR04MB6885CA8A965A49C456454254F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <3293d698bf26ecf08f22e7e2ffe55e74@walle.cc>
 <AM7PR04MB688518B8AE836C2CC37FED6AF8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <de68e6861f0ab947642c847b3b645503@walle.cc>
 <AM7PR04MB6885044C8AE85FE369285186F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <d6ecf5fea0d8bde80f7563b4cb586b59@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Am 2020-11-24 10:22, schrieb Y.b. Lu:
> Hi Michael,
> 
>> -----Original Message-----
>> From: Michael Walle <michael@walle.cc>
>> Sent: Tuesday, November 24, 2020 5:08 PM
>> To: Y.b. Lu <yangbo.lu@nxp.com>
>> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>; Shawn Guo
>> <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob Herring
>> <robh+dt@kernel.org>; linux-arm-kernel@lists.infradead.org;
>> devicetree@vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>; 
>> Ulf
>> Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org;
>> linux-kernel@vger.kernel.org; Ashish Kumar <ashish.kumar@nxp.com>
>> Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
>> controllers use fixed indices
>> 
>> Am 2020-11-24 10:02, schrieb Y.b. Lu:
>> > Hi Michael,
>> >
>> >> -----Original Message-----
>> >> From: Michael Walle <michael@walle.cc>
>> >> Sent: Tuesday, November 24, 2020 4:55 PM
>> >> To: Y.b. Lu <yangbo.lu@nxp.com>
>> >> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>; Shawn Guo
>> >> <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob Herring
>> >> <robh+dt@kernel.org>; linux-arm-kernel@lists.infradead.org;
>> >> devicetree@vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>;
>> >> Ulf
>> >> Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org;
>> >> linux-kernel@vger.kernel.org; Ashish Kumar <ashish.kumar@nxp.com>
>> >> Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
>> >> controllers use fixed indices
>> >>
>> >> Am 2020-11-24 09:47, schrieb Y.b. Lu:
>> >> > Hi Michael,
>> >> >
>> >> >> -----Original Message-----
>> >> >> From: Michael Walle <michael@walle.cc>
>> >> >> Sent: Tuesday, November 24, 2020 4:03 PM
>> >> >> To: Y.b. Lu <yangbo.lu@nxp.com>
>> >> >> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>; Shawn Guo
>> >> >> <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob Herring
>> >> >> <robh+dt@kernel.org>; linux-arm-kernel@lists.infradead.org;
>> >> >> devicetree@vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>;
>> >> >> Ulf
>> >> >> Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org;
>> >> >> linux-kernel@vger.kernel.org; Ashish Kumar <ashish.kumar@nxp.com>
>> >> >> Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
>> >> >> controllers use fixed indices
>> >> >>
>> >> >> Am 2020-11-24 08:41, schrieb Y.b. Lu:
>> >> >> > Hi Vladimir,
>> >> >> >
>> >> >> >> -----Original Message-----
>> >> >> >> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>> >> >> >> Sent: Friday, November 20, 2020 5:30 PM
>> >> >> >> To: Y.b. Lu <yangbo.lu@nxp.com>
>> >> >> >> Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li
>> <leoyang.li@nxp.com>;
>> >> Rob
>> >> >> >> Herring <robh+dt@kernel.org>; linux-arm-kernel@lists.infradead.org;
>> >> >> >> devicetree@vger.kernel.org; Adrian Hunter
>> <adrian.hunter@intel.com>;
>> >> >> >> Ulf
>> >> >> >> Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org;
>> >> >> >> linux-kernel@vger.kernel.org; Ashish Kumar
>> <ashish.kumar@nxp.com>;
>> >> >> >> Michael Walle <michael@walle.cc>
>> >> >> >> Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD
>> card
>> >> >> >> controllers use fixed indices
>> >> >> >>
>> >> >> >> On Fri, Nov 20, 2020 at 02:04:02AM +0000, Y.b. Lu wrote:
>> >> >> >> > Hi Vladimir,
>> >> >> >> >
>> >> >> >> > I have already upstreamed a patch for all affected layerscape
>> boards.
>> >> >> >> >
>> >> >> >>
>> >> >>
>> >>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kern
>> >> >>
>> >>
>> el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fshawnguo%2Flinux.git%2
>> >> >>
>> >>
>> Fcommit%2F&amp;data=04%7C01%7Cyangbo.lu%40nxp.com%7C498622ade
>> >> >>
>> >>
>> e704fc0042008d8904f6184%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
>> >> >> %7C0%7C637418017917635725%7CUnknown%7CTWFpbGZsb3d8eyJW
>> Ijoi
>> >> M
>> >> >>
>> >>
>> C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000
>> >> >>
>> >>
>> &amp;sdata=OciS3q%2BmP%2Bz4x1ewPHDigmUkgIZmBgUlRRTm4yaxB7s%3D
>> >> >> &amp;reserved=0?
>> >> >> >> h=imx/dt64&id=342ab37ecaf8c1b10dd3ca9a1271db29a6af0705
>> >> >> >> >
>> >> >> >> > Please check whether it works for you.
>> >> >> >>
>> >> >> >> Thanks, one can tell that I haven't done my due diligence of checking
>> >> >> >> Shawn's tree first. I'll cherry-pick that patch and carry on with my
>> >> >> >> work.
>> >> >> >>
>> >> >> >> However, the fact still remains that Michael has expressed his opinion
>> >> >> >> regarding mmcblk0 vs mmcblk1. Do you think that we could make
>> the
>> >> >> >> aliases a per-board option instead of per-SoC? Consider that there
>> >> >> >> might
>> >> >> >> even be boards that only use SD card. It would be strange for the
>> >> >> >> block
>> >> >> >> device in that case to be called /dev/mmcblk1.
>> >> >> >
>> >> >> > I don't think it's a problem in board dts to define board specific
>> >> >> > thing, like re-defining alias, and disabling any IP it not using.
>> >> >>
>> >> >> First, why would you put it in the architecture include anyway? That
>> >> >> is really board-specific. That is like you would say, we enable all
>> >> >> devices and a board could potentially disable it. TBH it seems that
>> >> >> this will fit your reference boards and you don't care about the
>> >> >> other ones which uses that include.
>> >> >
>> >> > In soc dtsi, this is giving default alias for two esdhc controllers.
>> >> > This is not board specific.
>> >> > That's natural esdhc0 is mmc0 and esdhc1 is mmc1.
>> >>
>> >> How could this be not board specific if there are at least three
>> >> different use cases the board can choose from - and needs three
>> >> different configurations:
>> >>
>> >> (1) eMMC at /dev/mmcblk0, SD card at /dev/mmcblk1
>> >> (2) SD card at /dev/mmcblk0, eMMC at /dev/mmcblk1
>> >> (3) no eMMC at all, SD card at /dev/mmcblk0
>> >
>> > Not matter it's SD card or eMMC card, if it's on esdhc0, use
>> > /dev/mmcblk0.
>> > Not matter it's SD card or eMMC card, if it's on esdhc1, use
>> > /dev/mmcblk1.
>> > It's not related to board and card type, it's only related to esdhc
>> > interface in use.
>> 
>> And what interace is used is board specific, isn't it?
> 
> Again, for all boards, use /dev/mmcblk0 for card on esdhc0 interface,
> and /dev/mmcblk1 for card on esdhc1 interface.
> That's not board specific.

So why don't you enable the devices by default then? That would be the
same reasoning, wouldn't it? Or even enable all devices by default. 
Nobody
does that. But the boards themselves enable the devices which _they_
are actually using.


>> >> your include only support (1). If a board needs (2) or (3) it has to
>> >> override the configuration in the _common_ include.
>> >>
>> >> >> And as Vladimir pointed out, what do you do if you just have the eMMC
>> >> >> on the LS1028A. It will be mmcblk1 unless you do something like the
>> >> >> following in the board dts:
>> >> >>
>> >> >> mmc0 = &esdhc;
>> >> >> /delete-property/ mmc1;
>> >> >>
>> >> >> That is really cumbersome, isnt it?
>> >> >
>> >> > The soc dtsi gives default alias to make esdhc0 as mmc0, and esdhc1 as
>> >> > mmc1, the use case just needs to consider which esdhc controller is
>> >> > used. That's fixed index for it.
>> >> > No matter how the board is designed, there are two esdhc controllers
>> >> > in soc. It's probed as mmc0 and mmc1.
>> >> > It's use case that should choose the right mmc device. It is not the
>> >> > dts that should be changed to suit use case.
>> >> > If the board owner insists to change alias to make esdhc1 as mmc0, I
>> >> > think no problem. Just do it in board dts to override the default one.
>> >>
>> >> Still, why would this be enforced in the common include? What is the
>> >> advnatage here? I only see disadvantages.
>> 
>> You didn't answer this unfortunately.
> 
> As I explained,
> "Again, for all boards, use /dev/mmcblk0 for card on esdhc0 interface,
> and /dev/mmcblk1 for card on esdhc1 interface.
> That's not board specific."
> 
> Without such definition, the index is random for each booting.

No the question was why to include this into the common header. Not into
the board specific ones.

-michael
