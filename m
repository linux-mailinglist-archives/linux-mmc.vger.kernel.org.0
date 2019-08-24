Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD8749C0B5
	for <lists+linux-mmc@lfdr.de>; Sun, 25 Aug 2019 00:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfHXWZf (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 24 Aug 2019 18:25:35 -0400
Received: from mail.overt.org ([157.230.92.47]:38521 "EHLO mail.overt.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbfHXWZf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 24 Aug 2019 18:25:35 -0400
Received: from authenticated-user (mail.overt.org [157.230.92.47])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.overt.org (Postfix) with ESMTPSA id B5F0E3F1EC;
        Sat, 24 Aug 2019 17:25:33 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=overt.org; s=mail;
        t=1566685534; bh=quYok80zcQGVOD6uBSPZrXu2vJWuvo2S/3C1NqDKuVo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mMwoLRbKoY3TGmnapnDrWNg86MPmK+wCjO5DgGhs3rCtoPHKDhSrJ5XBJIwtloU6B
         ZF1bUGTTHRS83aqS5P9nXCHHo0HH95UuEHqu0KlzFKZaMwZAfZHBU/yS26yq5NtJae
         5FeitwVjCvc7uYr/HHCVhyHdj7I9/7/26q/TEgmTu5a/rhMul+thC3eRlv/dXLwnxo
         SZyeMK4URoi0E3cjCnBnQsnasQ7Fj7f8TNje475Yf79OJjbut+aK46MOcKrmJHV5jV
         EG/yKsRwkIT4CZjakTCJf4y6cJid2YtaXbeqkBNina+pslR14lZBqmB2yW5BhB2NjI
         j91SPMHD672Xw==
Date:   Sat, 24 Aug 2019 15:25:30 -0700
From:   Philip Langdale <philipl@overt.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: rtsx_pci: Do not set MMC_CAP2_FULL_PWR_CYCLE
Message-ID: <20190824152530.432fe9a2@fido6>
In-Reply-To: <41d073f646b1f94adcf41b2cf0f798d8@overt.org>
References: <20190811021917.29736-1-philipl@overt.org>
        <CAPDyKFr5z4YknbS4_9NmzQ0TMHf+SqGxd5HyMGi4oeXAWFeSHw@mail.gmail.com>
        <41d073f646b1f94adcf41b2cf0f798d8@overt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 22 Aug 2019 16:05:22 -0700
Philip Langdale <philipl@overt.org> wrote:

> So, what's actually wrong? Well, either the controller doesn't really 
> support the
> low voltage range, or the card doesn't. As my machine here only has a 
> microsd slot,
> I can't test with an MMCplus card to see if low voltage MMC would
> work. Without that
> I can't say whether we should remove the host flag or somehow
> blacklist low voltage
> range on these cards (or any SD card?)
> 
> Would love to get your thoughts.

I did more reading and thinking. In the MMC spec, a low-voltage (1.8V)
supporting card can run at 1.8V directly from start up (and this is
what the existing core logic does). But for SD cards, i think this is
not true. I read the Low-Voltage-Signaling announcement which says
there is a new negotiation mechanism but I can't find it documented in
the SD 6.0 spec (despite the announcement saying it's part of the SD
6.0 spec). That implies that direct bring up at low voltage doesn't
work like it does for an MMC card.

Also, again without seeing an actual spec, I'd guess this means that
having bit 7 set in OCR cannot be interpreted the same way for an SD
card as for an MMC card. Perhaps it should be read to mean that the LVS
negotiation process should be executed, but even that might be silly,
because the whole point of LVS is to support scenarios where only 1.8V
is usable - that means negotiation must be done with no prior
knowledge. So you can't read OCR until you already know that 1.8V is
supported.

So maybe the punchline here is that shared logic that will try and
bring up a card at 1.8V should be MMC only and for SD cards, the LVS
negotiation should be implemented instead.

Finally, this Sandisk A2 card doesn't have the LV logo on it, so I
don't know whether it would support 1.8V operation if the LVS
negotiation was done directly or not - and I don't know whether setting
bit 7 in OCR is correct for an LV compliant card.

Lots of open questions.

--phil
