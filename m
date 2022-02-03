Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A837C4A8142
	for <lists+linux-mmc@lfdr.de>; Thu,  3 Feb 2022 10:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiBCJQI (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 3 Feb 2022 04:16:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37856 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230259AbiBCJQH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Feb 2022 04:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643879766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=upgByqr3JPm/pcAvrDmZYGayUFSi5IEqwps1GZG/nc0=;
        b=Qxm8VKikeG+QX0VkKNto9q14lv5+WZbJcZZAoVEaNjktiKsBQzKsg5FAUdTx0ff1BdH2uT
        SdkfTdEAPkyxg8rOFd3FoQHEOjmPG6TATYMCIDAkTots7hqZSH9oWHjaj8snXJTByyvY9L
        bSPLjj/356QAfsgv+kyU/8ET4DmByDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-EoxAI1sUPIO6LAQoAIe3XA-1; Thu, 03 Feb 2022 04:16:03 -0500
X-MC-Unique: EoxAI1sUPIO6LAQoAIe3XA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 306AA814245;
        Thu,  3 Feb 2022 09:16:02 +0000 (UTC)
Received: from localhost (unknown [10.39.192.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09D181062227;
        Thu,  3 Feb 2022 09:15:54 +0000 (UTC)
Date:   Thu, 3 Feb 2022 09:15:53 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 2/5] virtio_blk: simplify refcounting
Message-ID: <YfudSXcT2rNh/Jhl@stefanha-x1.localdomain>
References: <20220202155659.107895-1-hch@lst.de>
 <20220202155659.107895-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PeAgK0yhrSE0EZQO"
Content-Disposition: inline
In-Reply-To: <20220202155659.107895-3-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--PeAgK0yhrSE0EZQO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 02, 2022 at 04:56:56PM +0100, Christoph Hellwig wrote:
> @@ -985,8 +947,6 @@ static void virtblk_remove(struct virtio_device *vdev)
>  	kfree(vblk->vqs);
> =20
>  	mutex_unlock(&vblk->vdev_mutex);
> -
> -	virtblk_put(vblk);
>  }

Thank you, this is a nice cleanup! One question:

File systems are unmounted and block devices are not open. PCI hot
unplug calls virtblk_remove(). It looks vblk is used after being freed
by virtblk_free_disk() halfway through virtblk_remove()?

  static void virtblk_remove(struct virtio_device *vdev)
  {
          struct virtio_blk *vblk =3D vdev->priv;
 =20
          /* Make sure no work handler is accessing the device. */
          flush_work(&vblk->config_work);
 =20
          del_gendisk(vblk->disk);
          blk_cleanup_disk(vblk->disk);
	          ^--- is virtblk_free_disk() called here?
          blk_mq_free_tag_set(&vblk->tag_set);
	                         ^--- use after free
 =20
          mutex_lock(&vblk->vdev_mutex);
 =20
          /* Stop all the virtqueues. */
          virtio_reset_device(vdev);
 =20
          /* Virtqueues are stopped, nothing can use vblk->vdev anymore. */
          vblk->vdev =3D NULL;
 =20
          vdev->config->del_vqs(vdev);
          kfree(vblk->vqs);
 =20
          mutex_unlock(&vblk->vdev_mutex);
  }

Stefan

--PeAgK0yhrSE0EZQO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmH7nUkACgkQnKSrs4Gr
c8jN5Af4iefIKAa+WFTDInuj0dl0GqxL+bsDsqNBDCW3K7iOiQgIseKP/QpFl3n6
4mtnQAzuafGzOc9g2LlaL1R3tTbz3hK5Vo2MeNSwI60VfMkOGmxh2G9ORRqVBfG6
K884fdqqhR5QDBaJq9cysUjqUtCw6adOa2LR0jqbwX4SbwJhpab1W/zBy2jq7XWD
WP+2D/1S5nmR8VwAYqpI5xFzoxtTmkN2mVR7niF2nQxutTzeorYHwMF9ZEPkoAcB
nDUDhWU5rREG2a26dOemMRcitNHjT85xZxWYGB+SvdZCgT9kwJP69gJTkeJ+smC6
2uOsaWdcWDALmkpFn1IdRd5uX5r3
=0b+G
-----END PGP SIGNATURE-----

--PeAgK0yhrSE0EZQO--

