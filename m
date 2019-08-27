Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A88EF9DC01
	for <lists+linux-mmc@lfdr.de>; Tue, 27 Aug 2019 05:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfH0Dbx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 26 Aug 2019 23:31:53 -0400
Received: from mail.overt.org ([157.230.92.47]:40343 "EHLO mail.overt.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbfH0Dbx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 26 Aug 2019 23:31:53 -0400
Received: from authenticated-user (mail.overt.org [157.230.92.47])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.overt.org (Postfix) with ESMTPSA id 5ED9C3F210;
        Mon, 26 Aug 2019 22:31:52 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=overt.org; s=mail;
        t=1566876712; bh=JhBrhO8aVl12j42l+Db4gqsZ0fnb6wWi+UVmhJ0vjDw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f3OGZnAtXBDfN2SKGrBVMTUNlAvIg7U5iqYq/tPj8dKEELFE67ENib2x8OEsCY55N
         9o/gvVDBd3CEp4B/6UZXxgN7YBVyESzHRqBCH+fw2rF85eGgILS4KFS8T+FNi+BJ9G
         dRGfJXFKQEQXCM0fnBbHGTHCJz1NeLfQGiBsivBrytkZl55G0dTaSn4VffuNn7CNMo
         GDck2xGX0/8b3lMgmaufSVkxzP9jw5d3pI5PnJbl8ZKDyCh6fANInG1rKDvnRoWMMu
         0yTQrpdm1orKDvUrFUhp+8hVdeujvBlgxV5q0QpbxSfiOGIH+7Ju91rx4yLq51rIbS
         KMH3unKNnIQdw==
Date:   Mon, 26 Aug 2019 20:31:49 -0700
From:   Philip Langdale <philipl@overt.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: rtsx_pci: Do not set MMC_CAP2_FULL_PWR_CYCLE
Message-ID: <20190826203149.1354d8c8@fido6>
In-Reply-To: <03f692ac16a1854ee18f5526f8a53530@overt.org>
References: <20190811021917.29736-1-philipl@overt.org>
        <CAPDyKFr5z4YknbS4_9NmzQ0TMHf+SqGxd5HyMGi4oeXAWFeSHw@mail.gmail.com>
        <41d073f646b1f94adcf41b2cf0f798d8@overt.org>
        <20190824152530.432fe9a2@fido6>
        <CAPDyKFq3o-StNCuNA3vy8uW5pO=eu1BheQXyT4ftmfhuPSUnBg@mail.gmail.com>
        <03f692ac16a1854ee18f5526f8a53530@overt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 26 Aug 2019 11:06:26 -0700
Philip Langdale <philipl@overt.org> wrote:

> 
> I started looking at how we might make a general change to ignore for 
> all
> cards, and in the process, I saw that we already have a way to 
> differentiate
> ocr_avail for different card types, and the sdhci driver uses this to
> elide the low voltage range when dealing with SD cards. So I've made
> the small change to have the rtsx drivers set ocr_avail_sd and skip
> the low voltage
> range support. This makes the cards work, as you'd expect.
> 
> There's still a fair claim that the elidation logic should move into
> the core,
> so that all host controllers automatically benefit, but I think I
> should leave
> that to you. It's a core change and I don't pretend to understand all 
> the
> considerations for all the various supported controllers.
> 
> I've sent a new diff with the rtsx-specific fix.
> 

More reading == more thoughts.

So, I went through the simplified 6.0 spec more carefully and this is
what I've extracted:

* Low Voltage Signalling: The 1.8V I/O voltage we already support
* Low Voltage Interface: A new 6.0 feature for setting VDD to 1.8V

The LVI is documented in the "Low Voltage Interface Addendum" that is
not included in the simplified spec. Why? Who knows. Do you have access
to this by any chance?

There are specific references in the simplified spec when discussing
the OCR that make it pretty clear that bit 7 in the OCR indicates the
card supports LVI and can be initialised in 1.8V mode if the LVI
negotiation is followed.

There is also a clear statement that an A2 card must support LVI.

That means that the Sandisk card I'm looking at is 'correctly' setting
bit 7 in OCR to indicate LVI support. And there's no "LV" logo because
A2 implies LVI.

It's deeply annoying that Low Voltage initialisation is done
differently for SD vs MMC despite using the same mechanism to indicate
support.

Overall, this implies that until we can implement LVI negotiation, it
would be semantically correct to ignore bit 7 explicitly for SD cards,
and hopefully we'd eventually be able to implement the negotiation and
support low voltage VDD when the controller and card support it.

--phil
