Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 448899D56D
	for <lists+linux-mmc@lfdr.de>; Mon, 26 Aug 2019 20:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbfHZSG2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 26 Aug 2019 14:06:28 -0400
Received: from mail.overt.org ([157.230.92.47]:57769 "EHLO mail.overt.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732525AbfHZSG2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 26 Aug 2019 14:06:28 -0400
Received: from authenticated-user (mail.overt.org [157.230.92.47])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.overt.org (Postfix) with ESMTPSA id 028003F246;
        Mon, 26 Aug 2019 13:06:27 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=overt.org; s=mail;
        t=1566842787; bh=hfY06QukH5kf6cYDg8QacTXqf0paOOlcUuCcUJeyEmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mDobP51IlAAp7ET850DMbIYpzRpIUhWgU08IPsqQhBuFVM6PXQ7mBecs2ewS6NNVt
         DL8UEzvNCNMsTKXBuH26wWUDM3sYp+F3rx7ngfowknAjF1ELRUUcKht1Y+N1ZBqh3x
         +nKwbUTe+7pli8ap8iZcJAYENCYRZ3nT9QdrxjcT7BDF2qA1rhRWByY5r+vHsqjRFJ
         KfNyNp5lMhDRDriqiSUwfzaQpc87EGK7aO6lb9AUj6rq7pPC4IsJInwE0XvHfvCpax
         bXb5nOhYajfP22Fv769Jnq4jMEG3ce4Rjwa7bp1sR9Ngvwr25gKmfMjs3Zeha0e66/
         wIQHvHhCbm+vg==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 26 Aug 2019 11:06:26 -0700
From:   Philip Langdale <philipl@overt.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: rtsx_pci: Do not set MMC_CAP2_FULL_PWR_CYCLE
In-Reply-To: <CAPDyKFq3o-StNCuNA3vy8uW5pO=eu1BheQXyT4ftmfhuPSUnBg@mail.gmail.com>
References: <20190811021917.29736-1-philipl@overt.org>
 <CAPDyKFr5z4YknbS4_9NmzQ0TMHf+SqGxd5HyMGi4oeXAWFeSHw@mail.gmail.com>
 <41d073f646b1f94adcf41b2cf0f798d8@overt.org> <20190824152530.432fe9a2@fido6>
 <CAPDyKFq3o-StNCuNA3vy8uW5pO=eu1BheQXyT4ftmfhuPSUnBg@mail.gmail.com>
Message-ID: <03f692ac16a1854ee18f5526f8a53530@overt.org>
X-Sender: philipl@overt.org
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2019-08-26 08:39, Ulf Hansson wrote:
>> 
>> Finally, this Sandisk A2 card doesn't have the LV logo on it, so I
>> don't know whether it would support 1.8V operation if the LVS
>> negotiation was done directly or not - and I don't know whether 
>> setting
>> bit 7 in OCR is correct for an LV compliant card.
> 
> Yeah.
> 
> I think we can agree on that having bit7 set in OCR is not really
> useful for SD card. In principle I think we should just just ignore it
> for all SD cards.
> 
> Do you want to send a patch, or if you prefer, I can do it!?

I started looking at how we might make a general change to ignore for 
all
cards, and in the process, I saw that we already have a way to 
differentiate
ocr_avail for different card types, and the sdhci driver uses this to
elide the low voltage range when dealing with SD cards. So I've made the
small change to have the rtsx drivers set ocr_avail_sd and skip the low 
voltage
range support. This makes the cards work, as you'd expect.

There's still a fair claim that the elidation logic should move into the 
core,
so that all host controllers automatically benefit, but I think I should 
leave
that to you. It's a core change and I don't pretend to understand all 
the
considerations for all the various supported controllers.

I've sent a new diff with the rtsx-specific fix.

Thanks,

--phil
