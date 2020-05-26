Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FEE1CBA0D
	for <lists+linux-mmc@lfdr.de>; Fri,  8 May 2020 23:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEHVrC (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 8 May 2020 17:47:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45962 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727778AbgEHVrB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2020 17:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588974420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D2IduH1CF5NRPIpQWbLKTdLk97fqdqm/1QiS9bCgssc=;
        b=BYaACNZhYUh99iR3p7ZXCfVknBiOQ/bs57BD/qT+kyCa8xAAGjgzt9HNWwS2g5hCZvSG3c
        comQdY3QAX63R/H2MIMBZNCOBVpeylULumdbj2Egf32liKuXUhg1coJs3gQrIy1n3ui0ni
        CY1yyezSsyRXL2WZ+kFOrpDWKVvHuVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-4mcOx4jwMjuckTDZW4qamQ-1; Fri, 08 May 2020 17:46:56 -0400
X-MC-Unique: 4mcOx4jwMjuckTDZW4qamQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6534E80183C;
        Fri,  8 May 2020 21:46:54 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E36C70467;
        Fri,  8 May 2020 21:46:44 +0000 (UTC)
Date:   Sat, 9 May 2020 05:46:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Baolin Wang <baolin.wang7@gmail.com>, axboe@kernel.dk,
        ulf.hansson@linaro.org, adrian.hunter@intel.com, arnd@arndb.de,
        linus.walleij@linaro.org, paolo.valente@linaro.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/7] block: Extand commit_rqs() to do batch
 processing
Message-ID: <20200508214639.GA1389136@T590>
References: <cover.1587888520.git.baolin.wang7@gmail.com>
 <c8bd9e5ba815a3f1bc9dac0a4bc2fbadadbc0a43.1587888520.git.baolin.wang7@gmail.com>
 <20200427154645.GA1201@infradead.org>
 <e4d47000-f89c-a135-ae58-011f0e9cc39e@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4d47000-f89c-a135-ae58-011f0e9cc39e@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, May 08, 2020 at 02:35:35PM -0700, Sagi Grimberg wrote:
> 
> > > diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> > > index f389d7c724bd..6a20f8e8eb85 100644
> > > --- a/include/linux/blk-mq.h
> > > +++ b/include/linux/blk-mq.h
> > > @@ -391,6 +391,7 @@ struct blk_mq_ops {
> > >   enum {
> > >   	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
> > >   	BLK_MQ_F_TAG_SHARED	= 1 << 1,
> > > +	BLK_MQ_F_FORCE_COMMIT_RQS = 1 << 3,
> > 
> > Maybe BLK_MQ_F_ALWAYS_COMMIT might be a better name?  Also this
> > flag (just like the existing ones..) could really use a comment
> > explaining it.
> 
> Would it make sense to elevate this flag to a request_queue flag
> (QUEUE_FLAG_ALWAYS_COMMIT)?

request queue flag usually is writable, however this case just needs
one read-only flag, so I think it may be better to make it as
tagset/hctx flag.

> 
> I'm thinking of a possibility that an I/O scheduler may be used
> to activate this functionality rather than having the driver set
> it necessarily...

Could you explain a bit why I/O scheduler should activate this
functionality?

batching submission may be good for some drivers, and currently
we only do it in limited way. One reason is that there is extra
cost for full batching submission, such as this patch requires
one extra .commit_rqs() for each dispatch, and lock is often needed
in this callback.

IMO it can be a win for some slow driver or device, but may cause
a little performance drop for fast driver/device especially in workload
of not-batching submission.


Thanks, 
Ming

