Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9439F7B9
	for <lists+linux-mmc@lfdr.de>; Wed, 28 Aug 2019 03:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfH1BSK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 27 Aug 2019 21:18:10 -0400
Received: from mail.overt.org ([157.230.92.47]:51727 "EHLO mail.overt.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfH1BSK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 27 Aug 2019 21:18:10 -0400
Received: from authenticated-user (mail.overt.org [157.230.92.47])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.overt.org (Postfix) with ESMTPSA id 5F2FA3F742;
        Tue, 27 Aug 2019 20:18:09 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=overt.org; s=mail;
        t=1566955089; bh=r3hDl8Xqr5lbJMpSNdTtYrzF5UcNKJsa4zF1e2FhZQA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EJ2P0Wug+puGaikX1wOVDt/r5ph5H4t+fGf47fcZVh8smhA2QLHd2z2/2NbmazkQl
         9KfGS/h08kCkRtTX9lTk6RtrmgHa8V7Upl82v4Q9RWuyeXJMklkvMSHyw8Bs6tyXW1
         RRQEKZqAihuAsBKML+n7e3Ag9t9njhFh2exA5tx6kzgpni+A9Y7sbcK1LTnrKKG9wG
         ztJygQYMV8umn1LOamNDMa59KchZJnwPuu8luphVASK5v7cgTtfjnKkOK7IDgWYU8T
         qh2I2m2fBDTkyLTrD3X7wm9NyyzkjhANYRk/FNbPutX9MZUiFCgQQ1mNQvcDbJeLV+
         fQlnoleT2/wmA==
Date:   Tue, 27 Aug 2019 18:18:07 -0700
From:   Philip Langdale <philipl@overt.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] mmc: rtsx_pci: Do not set MMC_CAP2_FULL_PWR_CYCLE
Message-ID: <20190827181807.05fb6aef@fido6>
In-Reply-To: <CAPDyKFp9oT=ouyTkTUizm0Lx-akehG5sapPV5CXzYp90HWiAgA@mail.gmail.com>
References: <20190811021917.29736-1-philipl@overt.org>
        <CAPDyKFr5z4YknbS4_9NmzQ0TMHf+SqGxd5HyMGi4oeXAWFeSHw@mail.gmail.com>
        <41d073f646b1f94adcf41b2cf0f798d8@overt.org>
        <20190824152530.432fe9a2@fido6>
        <CAPDyKFq3o-StNCuNA3vy8uW5pO=eu1BheQXyT4ftmfhuPSUnBg@mail.gmail.com>
        <03f692ac16a1854ee18f5526f8a53530@overt.org>
        <20190826203149.1354d8c8@fido6>
        <CAPDyKFp9oT=ouyTkTUizm0Lx-akehG5sapPV5CXzYp90HWiAgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 27 Aug 2019 10:12:15 +0200
Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> According to the above, I don't think we ever need to care about bit 7
> in the OCR. But yes, supporting LVI may be complicated, but that's
> another story. :-)

Yes. Sorry, this has been very confusing for me. With the context you
provided, it is clear the LVI is still referring to signal voltage. So
the bit 7 being set for these cards looks like a mistake and
out-of-spec. Surprising from Sandisk.
 
> Anyway, I decided to post a patch, please test it at your side and see
> if it fixes the problem for you.

Took a look and responded. Did the trick, as you'd expect.

Much thanks!

--phil
