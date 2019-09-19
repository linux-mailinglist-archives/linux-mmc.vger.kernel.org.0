Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F134B87F4
	for <lists+linux-mmc@lfdr.de>; Fri, 20 Sep 2019 01:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390883AbfISXRm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-mmc@lfdr.de>); Thu, 19 Sep 2019 19:17:42 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48633 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389806AbfISXRm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Sep 2019 19:17:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46ZCS303qyz9s7T;
        Fri, 20 Sep 2019 09:17:38 +1000 (AEST)
Date:   Fri, 20 Sep 2019 09:17:30 +1000
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wjXF63BKNJH=GtnnoJmXZHEnRwjgeu4foJQvFYYBm9HHA@mail.gmail.com>
References: <20190918152748.GA21241@infradead.org> <CAHk-=wjXF63BKNJH=GtnnoJmXZHEnRwjgeu4foJQvFYYBm9HHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [GIT PULL] dma-mapping updates for 5.4
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>
CC:     linux-mmc@vger.kernel.org,
        iommu <iommu@lists.linux-foundation.org>,
        xen-devel@lists.xenproject.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Michael Ellerman <michael@ellerman.id.au>
Message-ID: <D422FEED-06F6-44BE-955F-90318693FD96@ellerman.id.au>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 20 September 2019 6:33:50 am AEST, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>On Wed, Sep 18, 2019 at 8:27 AM Christoph Hellwig <hch@infradead.org>
>wrote:
>>
>> please pull the dma-mapping updates for 5.4.
>
>Pulled.
>
>> In addition to the usual Kconfig conflics where you just want to keep
>> both edits there are a few more interesting merge issues this time:
>>
>>  - most importanly powerpc and microblaze add new callers of
>>    dma_atomic_pool_init, while this tree marks the function static
>>    and calls it from a common postcore_initcall().  The trivial
>>    functions added in powerpc and microblaze adding the calls
>>    need to be removed for the code to compile.  This will not show up
>>    as a merge conflict and needs to be dealt with manually!
>
>So I haven't gotten the powerpc or microblaze pull requests yet, so
>I'm not able to fix that part up yet.
>
>Intead, I'm cc'ing Michael Ellerman and Michal Simek to ask them to
>remind me when they _do_ send those pull requests, since otherwise I
>may well forget and miss it. Without an actual data conflict, and
>since this won't show up in my build tests either, it would be very
>easy for me to forget.
>
>Micha[e]l, can you both please make sure to remind me?

Yeah I was aware of it, and will make sure to remind you in my pull request.

cheers

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
