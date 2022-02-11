Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875D84B1CA0
	for <lists+linux-mmc@lfdr.de>; Fri, 11 Feb 2022 03:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343763AbiBKCgL (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 10 Feb 2022 21:36:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244563AbiBKCgL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Feb 2022 21:36:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2DAABFD
        for <linux-mmc@vger.kernel.org>; Thu, 10 Feb 2022 18:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644546969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wUVqFARDBJNnBok2lT0WfqI736phrHJDPkbze9E0f/c=;
        b=TyQmCgEEL+ScYvc9YS+/dNUvFexUKEZHNjP28eYiw61v6Sn7RDYDHId6MjWXAsJL4BdBfb
        g/oKGlO1gOOQu4bM5bko6KSLQTp2jJJTog7GClX+S5XjOb0qbL+5yNyDllUQixm2Mbn9eT
        qnuVxC1DS765KyArJkzmkKy9thq0C2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-oQOwLwdgPe24Kq2cup0Gaw-1; Thu, 10 Feb 2022 21:36:06 -0500
X-MC-Unique: oQOwLwdgPe24Kq2cup0Gaw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DA80835B47;
        Fri, 11 Feb 2022 02:36:05 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EF608E2E8;
        Fri, 11 Feb 2022 02:35:14 +0000 (UTC)
Date:   Fri, 11 Feb 2022 10:35:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 2/5] memstick/ms_block: simplify refcounting
Message-ID: <YgXLXcwf8fLK3yti@T590>
References: <20220209082121.2628452-1-hch@lst.de>
 <20220209082121.2628452-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209082121.2628452-3-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Feb 09, 2022 at 09:21:17AM +0100, Christoph Hellwig wrote:
> Implement the ->free_disk method to free the msb_data structure only once
> the last gendisk reference goes away instead of keeping a local refcount.
> 

The approach looks good, just the error handling needs to be careful,
such as, once driver data is bound to disk->private_data, the previous
error handling code shouldn't touch/free the driver data any more. That
said assigning disk->private_data implies driver data ownership transfer
after this conversion.

Such as, in msb_init_disk(), once blk_cleanup_disk() is done, the code
branch of out_release_id shouldn't be run; msb_probe() has the similar
issue too.

Thanks,
Ming

