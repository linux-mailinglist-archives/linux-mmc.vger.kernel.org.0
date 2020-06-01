Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D251EA330
	for <lists+linux-mmc@lfdr.de>; Mon,  1 Jun 2020 13:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgFAL6h (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 1 Jun 2020 07:58:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59942 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725847AbgFAL6h (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Jun 2020 07:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591012716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iXBGuAS9V5LVs9dboAYML/qojIHGctw2jyNMqjA5r9I=;
        b=W9mN+bK8Ni42gaJUTM03RhcQNb6+s3UvQfx6MWZG82A49dp5lglArf2FEwxaSJmonsYQVU
        gO8HxRTaifsWMTwjllijVlgm3uFYZjudIIZftTIkFJNepHiDHzBMoJxlTSIo8zgaGq5CjC
        a6l72dVoit5pwMK44xN8CqqYBI6rYWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-K7aiPOhjOHuBoJ5iS8Efdg-1; Mon, 01 Jun 2020 07:58:32 -0400
X-MC-Unique: K7aiPOhjOHuBoJ5iS8Efdg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38216100CCC0;
        Mon,  1 Jun 2020 11:58:30 +0000 (UTC)
Received: from T590 (ovpn-13-152.pek2.redhat.com [10.72.13.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C5065D9C9;
        Mon,  1 Jun 2020 11:58:22 +0000 (UTC)
Date:   Mon, 1 Jun 2020 19:58:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH] block: Flag elevators suitable for single queue
Message-ID: <20200601115818.GB1190838@T590>
References: <20200528081003.238804-1-linus.walleij@linaro.org>
 <20200601074957.GE1181806@T590>
 <CACRpkdYL4-Z=kaS+RfniVr=Sn-yOf+=CKMJDsn=eTK3atmGohg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYL4-Z=kaS+RfniVr=Sn-yOf+=CKMJDsn=eTK3atmGohg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Jun 01, 2020 at 01:36:54PM +0200, Linus Walleij wrote:
> On Mon, Jun 1, 2020 at 9:50 AM Ming Lei <ming.lei@redhat.com> wrote:
> > On Thu, May 28, 2020 at 10:10:03AM +0200, Linus Walleij wrote:
> > > The Kyber block scheduler is not suitable for single hardware
> > > queue devices, so add a new flag for single hardware queue
> > > devices and add that to the deadline and BFQ schedulers
> > > so the Kyber scheduler will not be selected for single queue
> > > devices.
> >
> > The above may not be true for some single hw queue high performance HBA(
> > such as megasas), which can get better performance from none, so it is
> > reasonable to get better performance from kyber, see 6ce3dd6eec11 ("blk-mq:
> > issue directly if hw queue isn't busy in case of 'none'"), and the
> > following link:
> >
> > https://lore.kernel.org/linux-block/20180710010331.27479-1-ming.lei@redhat.com/
> 
> I see, but isn't the case rather that none is preferred and kyber gives
> the same characteristics because it's not standing in the way
> as much?

Kyber has its own characteristic, such as fair read & write, better
IO merge. And the decision on scheduler isn't only related with device,
but also with workloads.

> 
> It looks like if we should add a special flag for these devices with
> very fast single queues so they can say "I prefer none", do you
> agree?

I am not sure if it is easy to add such flag, because it isn't only
related with HBA, but also with the attached disks.


Thanks,
Ming

