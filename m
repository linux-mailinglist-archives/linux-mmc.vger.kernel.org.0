Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4851EA2CF
	for <lists+linux-mmc@lfdr.de>; Mon,  1 Jun 2020 13:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgFALhI (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 1 Jun 2020 07:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgFALhI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Jun 2020 07:37:08 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD71C061A0E
        for <linux-mmc@vger.kernel.org>; Mon,  1 Jun 2020 04:37:07 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so6242174ljc.8
        for <linux-mmc@vger.kernel.org>; Mon, 01 Jun 2020 04:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uQTt+MIIpyDA4belDkYAgM2iFZj3fYj7DkPTdahh8pc=;
        b=mFkTPyu0DgEndR/rPSLh+6SZhzSM1qBKDd8PBw9+8FvGjQLyi0X4GhIxr44O0HNY9S
         B0O6ex76hLxTjxqQ49jCMJRn0P5+NwecUxkmaO+2TZvf9guPUE23aZWwKzSV1NJUHrcB
         XWTjHPSBLmNyW5MpuJeasWOkKZDwWVMWV09Kuyua48ogCAyegiD3cR/TT1fDiwk8TBVe
         y4rDFfND0mqTQzB7qrGexH6onIGb5aDrS1KF78f7S5UesCrxYaMWTUjSc4eMyNToKq9P
         irMvgdInEjpirCLJqjXh2FRQc1HtYKpAsHox8q+6ds+nU4NbLZHd1w9jc1+L/R2rJGAo
         PjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uQTt+MIIpyDA4belDkYAgM2iFZj3fYj7DkPTdahh8pc=;
        b=WprT6ugXR2y22FdkfcT82NWbnBvjP1ig5Ei8GcDgY4BhxOsFfO7up9rJRrgvQUCpKy
         wJ7OVwX8JLtK6Xp/9bGMoNoyzdxyjW++e7UqAAepJqg4BwKCWTVZaMfG5oAnLULKlIT6
         AOqfjDX7wpVbjwkxjzfjWq0nmg8pOcbDvwxPSDaZZWXi7PzhC0j6JKn1g9p/RYq1Iuiy
         XQJon8pdSIyiRJb0vBnDScct/3VSYq7ZqNM5Nq+u03og3IWaXvV9/OBwdKaakgHno5C5
         X74yI7WF2jmxMN24QZZs9PWKBIMDQom63a+aGg/2d+nKaWa1ZHEt8M1tHED2MmYU6fIg
         u0cg==
X-Gm-Message-State: AOAM530BYKEz+AcWXpDxNk+LG1MLtil/X/n5gjdfF/QBmBED9xrQ/NgD
        mdcN0UrV0mUBFoU0tjol5mNymYDTXpCSb39SsCLtrg==
X-Google-Smtp-Source: ABdhPJw+PTS+SxItJ484C0YqddclYX1X+Em1nuXbhwpxd5uIYFTeFzaNLSV1mhgdPe0vjmuzIUkSf9IuyYYdVc5kqow=
X-Received: by 2002:a2e:92d7:: with SMTP id k23mr1854314ljh.100.1591011425955;
 Mon, 01 Jun 2020 04:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200528081003.238804-1-linus.walleij@linaro.org> <20200601074957.GE1181806@T590>
In-Reply-To: <20200601074957.GE1181806@T590>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 1 Jun 2020 13:36:54 +0200
Message-ID: <CACRpkdYL4-Z=kaS+RfniVr=Sn-yOf+=CKMJDsn=eTK3atmGohg@mail.gmail.com>
Subject: Re: [PATCH] block: Flag elevators suitable for single queue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Jun 1, 2020 at 9:50 AM Ming Lei <ming.lei@redhat.com> wrote:
> On Thu, May 28, 2020 at 10:10:03AM +0200, Linus Walleij wrote:
> > The Kyber block scheduler is not suitable for single hardware
> > queue devices, so add a new flag for single hardware queue
> > devices and add that to the deadline and BFQ schedulers
> > so the Kyber scheduler will not be selected for single queue
> > devices.
>
> The above may not be true for some single hw queue high performance HBA(
> such as megasas), which can get better performance from none, so it is
> reasonable to get better performance from kyber, see 6ce3dd6eec11 ("blk-mq:
> issue directly if hw queue isn't busy in case of 'none'"), and the
> following link:
>
> https://lore.kernel.org/linux-block/20180710010331.27479-1-ming.lei@redhat.com/

I see, but isn't the case rather that none is preferred and kyber gives
the same characteristics because it's not standing in the way
as much?

It looks like if we should add a special flag for these devices with
very fast single queues so they can say "I prefer none", do you
agree?

Yours,
Linus Walleij
