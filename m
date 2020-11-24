Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE242C1F5F
	for <lists+linux-mmc@lfdr.de>; Tue, 24 Nov 2020 09:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgKXIDK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 24 Nov 2020 03:03:10 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:37159 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgKXIDK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2020 03:03:10 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3BE4023E45;
        Tue, 24 Nov 2020 09:03:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606204984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LdtFZjQj4nJpth6euyR4ivHCTaufrYR8pun171sr7w=;
        b=I5BI7ZEEc+PUzGevx0oD5I1fnLHp80tmJwQ0q5EqY8wDjtqtKnVxBt84fPY3FhXAzNtXaI
        oaxL+C3qzPZxEW27CMq7QIkUcCh5251ehDHM29RFxQqDdHB0xV4ZDHI4RgXi/CcUUjK1aj
        gnrPugYfQDaj4T+ZFXCmkjAba7f9yXM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Nov 2020 09:03:00 +0100
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
In-Reply-To: <VI1PR04MB6896C22F6B304F365C3BA626F8FB0@VI1PR04MB6896.eurprd04.prod.outlook.com>
References: <20201119155025.965941-1-vladimir.oltean@nxp.com>
 <AM7PR04MB688536E10A0B35D75A9F8F34F8FF0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201120093015.duel3yx63cbya77w@skbuf>
 <VI1PR04MB6896C22F6B304F365C3BA626F8FB0@VI1PR04MB6896.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <71a86b0fbc95892f8fd240e0919e7e23@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Am 2020-11-24 08:41, schrieb Y.b. Lu:
> Hi Vladimir,
> 
>> -----Original Message-----
>> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>> Sent: Friday, November 20, 2020 5:30 PM
>> To: Y.b. Lu <yangbo.lu@nxp.com>
>> Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob
>> Herring <robh+dt@kernel.org>; linux-arm-kernel@lists.infradead.org;
>> devicetree@vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>; 
>> Ulf
>> Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org;
>> linux-kernel@vger.kernel.org; Ashish Kumar <ashish.kumar@nxp.com>;
>> Michael Walle <michael@walle.cc>
>> Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
>> controllers use fixed indices
>> 
>> On Fri, Nov 20, 2020 at 02:04:02AM +0000, Y.b. Lu wrote:
>> > Hi Vladimir,
>> >
>> > I have already upstreamed a patch for all affected layerscape boards.
>> >
>> https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?
>> h=imx/dt64&id=342ab37ecaf8c1b10dd3ca9a1271db29a6af0705
>> >
>> > Please check whether it works for you.
>> 
>> Thanks, one can tell that I haven't done my due diligence of checking
>> Shawn's tree first. I'll cherry-pick that patch and carry on with my
>> work.
>> 
>> However, the fact still remains that Michael has expressed his opinion
>> regarding mmcblk0 vs mmcblk1. Do you think that we could make the
>> aliases a per-board option instead of per-SoC? Consider that there 
>> might
>> even be boards that only use SD card. It would be strange for the 
>> block
>> device in that case to be called /dev/mmcblk1.
> 
> I don't think it's a problem in board dts to define board specific
> thing, like re-defining alias, and disabling any IP it not using.

First, why would you put it in the architecture include anyway? That
is really board-specific. That is like you would say, we enable all
devices and a board could potentially disable it. TBH it seems that
this will fit your reference boards and you don't care about the
other ones which uses that include.

And as Vladimir pointed out, what do you do if you just have the eMMC
on the LS1028A. It will be mmcblk1 unless you do something like the
following in the board dts:

mmc0 = &esdhc;
/delete-property/ mmc1;

That is really cumbersome, isnt it?

-michael
